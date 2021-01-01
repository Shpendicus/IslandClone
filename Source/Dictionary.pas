﻿namespace RemObjects.Elements.System;

type
  Entry<T, U> = unit record
  public
    HashCode: Integer; // current hashcode
    Next: Integer; // contains reference to next item with the same hashcode
    Key : T;
    Value: U;
  end;

  ImmutableDictionary<T,U> = public class(sequence of KeyValuePair<T,U>)
  unit
    const EMPTYHASH: Integer = 0;
    const EMPTY_BUCKET: Integer = 0;
    const POSITIVE_INTEGER_MASK: UInt32 = $7FFFFFFF;
    const MIN_DICTIONATY_SIZE: Integer = 11;
    const DEFAULT_MAX_INDEX = 1;

    var fCount: Integer := 0;
    var fMaxUsedIndex: Integer := DEFAULT_MAX_INDEX;
    var fbucketTable: array of Integer; // contains "hash / fcapacity" and references to fTable

    var fFirstHole: Integer := EMPTY_BUCKET;
    var fEntriesTable: array of Entry<T, U>;
    var fComparer : IEqualityComparer<T>;

    method GetKeys: sequence of T; iterator;
    begin
      var i:=0;
      var idx := 0;
      while idx < fCount do begin
        if fEntriesTable[i].HashCode <> EMPTY_BUCKET then begin
          inc(idx);
          yield fEntriesTable[i].Key;
        end;
        inc(i);
      end;
    end;

    method GetValues: sequence of U;iterator;
    begin
      var i:=0;
      var idx := 0;
      while idx < fCount do begin
        if fEntriesTable[i].HashCode <> EMPTY_BUCKET then begin
          inc(idx);
          yield fEntriesTable[i].Value;
        end;
        inc(i);
      end;
    end;

    method DoAdd(hash: Integer; Key: T; Value: U);
    begin
      var pos := EMPTY_BUCKET;
      if fFirstHole <> EMPTY_BUCKET then begin
        pos := fFirstHole;
        fFirstHole := fEntriesTable[fFirstHole].Next;
      end
      else begin
        if fCount = length(fEntriesTable) - (DEFAULT_MAX_INDEX+1) then DoResize(CalcNextCapacity(length(fEntriesTable)));
        pos := fMaxUsedIndex;
        inc(fMaxUsedIndex);
      end;
      fEntriesTable[pos].HashCode := hash;
      fEntriesTable[pos].Next := EMPTY_BUCKET;
      fEntriesTable[pos].Key := Key;
      fEntriesTable[pos].Value := Value;

      var idx := CalcIndex(hash, length(fEntriesTable));
      if fbucketTable[idx] = EMPTY_BUCKET then
        fbucketTable[idx] := pos
      else begin
        idx := fbucketTable[idx];
        while fEntriesTable[idx].Next <> EMPTY_BUCKET do idx := fEntriesTable[idx].Next;
        fEntriesTable[idx].Next := pos;
      end;
      inc(fCount);
    end;

    method DoRemove(Hash, idx: Integer);
    begin
      var fbucketidx := CalcIndex(Hash, length(fEntriesTable));
      if fbucketTable[fbucketidx] = idx then begin
        // bucket table references to fEntriesTable entry
        fbucketTable[fbucketidx] := fEntriesTable[idx].Next;
      end
      else begin
        // idx is specifies index from "Next"
        var idx1 := fbucketTable[fbucketidx];
        while fEntriesTable[idx1].Next <> idx do idx1 := fEntriesTable[idx1].Next;
        fEntriesTable[idx1].Next := fEntriesTable[idx].Next;
      end;
      // clear "item"
      fEntriesTable[idx].HashCode := EMPTYHASH;
      fEntriesTable[idx].Next := fFirstHole;
      fEntriesTable[idx].Key := default(T);
      fEntriesTable[idx].Value := default(U);
      fFirstHole := idx;
      dec(fCount);
    end;

    method GetItem(Key: T): U;
    begin
      var hash := CalcHashCode(Key);
      var idx := IndexOfKey(hash, Key);
      if idx <> -1 then
        exit fEntriesTable[idx].Value
      else
        raise new Exception('Key isn''t found');
    end;

    method SetItem(Key: T; Value: U);
    begin
      var hash := CalcHashCode(Key);
      var idx := IndexOfKey(hash, Key);
      if idx <> -1 then
        fEntriesTable[idx].Value := Value
      else
        DoAdd(hash, Key,Value);
    end;

    method CalcIndex(Hash: Integer; aTableLen: Integer): Integer;
    begin
      if aTableLen = 0 then begin
        aTableLen := CalcNextCapacity(0);
        DoResize(aTableLen);
      end;
      var k := Hash and POSITIVE_INTEGER_MASK;
      exit k - (k/aTableLen)*aTableLen;
    end;

    method IndexOfKey(Hash: Integer; Key: T): Integer;
    begin
      var lIndex := CalcIndex(Hash, length(fEntriesTable));
      var k := fbucketTable[lIndex];
      while (k <> EMPTY_BUCKET) and (fEntriesTable[k].HashCode <> EMPTYHASH) do begin
        if (fEntriesTable[k].HashCode = Hash) and fComparer.Equals(fEntriesTable[k].Key,Key) then
          exit k
        else
          k := fEntriesTable[k].Next;
      end;
      exit -1;
    end;

    method IndexOfValue(Value: U): Integer;
    begin
      for i: Integer := 0 to fMaxUsedIndex - 1 do
        if (fEntriesTable[i].HashCode <> EMPTYHASH) and fEntriesTable[i].Value.Equals(Value) then exit i;
      exit -1;
    end;

    method CheckKeyForNil(Key:T);
    begin
      if Key = nil then raise new ArgumentNullException("Key is nil");
    end;

    method CalcHashCode(Key:T): Integer;
    begin
      CheckKeyForNil(Key);
      exit fComparer.GetHashCode(Key) or $80000000;
    end;

    method CalcNextCapacity(aCapacity: Integer): Integer;
    begin
      if aCapacity < MIN_DICTIONATY_SIZE then exit MIN_DICTIONATY_SIZE;
      if fCount = 0 then exit aCapacity;
      result := (aCapacity shl 1) + 1;
      if result > 50 then exit (result/100)*100 + 97
    end;

    method DoResize(aNewCapacity: Integer);
    begin
      if (aNewCapacity <= length(fEntriesTable)) and (fCount>0) then exit;
      var new_fbucketTable := new array of Integer(aNewCapacity);
{
      for i:Integer :=0 to length(new_fbucketTable)-1 do
        new_fbucketTable[i] := EMPTY_BUCKET;
}
      for i:Integer := 0 to length(fEntriesTable)-1 do begin
        fEntriesTable[i].Next := EMPTY_BUCKET;
      end;

      for i:Integer := DEFAULT_MAX_INDEX to fMaxUsedIndex-1 do begin
        var idx := CalcIndex(fEntriesTable[i].HashCode, aNewCapacity);

        if new_fbucketTable[idx] = EMPTY_BUCKET then begin
          new_fbucketTable[idx] := i;
          fEntriesTable[i].Next := EMPTY_BUCKET;
        end
        else begin
          idx := new_fbucketTable[idx];
          while (fEntriesTable[idx].Next <> EMPTY_BUCKET) do
            idx := fEntriesTable[idx].Next;
          fEntriesTable[idx].Next := i;
        end;
      end;
      var new_fEntriesTable := new array of Entry<T,U>(aNewCapacity);
      if fMaxUsedIndex > DEFAULT_MAX_INDEX then begin
        memmove(@new_fEntriesTable[0], @fEntriesTable[0], fMaxUsedIndex * sizeOf(Entry<T,U>));
      end;
      fbucketTable := new_fbucketTable;
      fEntriesTable := new_fEntriesTable;
    end;

  public
    constructor;
    begin
      constructor(MIN_DICTIONATY_SIZE);
    end;

    constructor(aComparer: nullable IEqualityComparer<T>);
    begin
      fComparer := aComparer;
      constructor;
    end;

    constructor(aCapacity: Int32);
    begin
      if fComparer = nil then fComparer := new DefaultEqualityComparer<T>;
      if aCapacity < MIN_DICTIONATY_SIZE then aCapacity := MIN_DICTIONATY_SIZE;
      DoResize(CalcNextCapacity(aCapacity));
    end;

    constructor(aCapacity: Int32; aComparer: nullable IEqualityComparer<T>);
    begin
      fComparer := aComparer;
      constructor(aCapacity);
    end;

    constructor(aDictionary: not nullable ImmutableDictionary<T,U>);
    begin
      constructor(aDictionary.Keys.Count);
      for each k in aDictionary.Keys do
        self[k] := aDictionary[k];
    end;

    constructor(aDictionary: not nullable ImmutableDictionary<T,U>; aComparer: nullable IEqualityComparer<T>);
    begin
      fComparer := aComparer;
      constructor(aDictionary);
    end;

    {$IF DARWIN}
    constructor(aDictionary: Foundation.NSDictionary<T,U>);
    begin
      constructor(aDictionary.count);
      for each k: T in aDictionary.allKeys do
        self[k] := aDictionary[k];
    end;

    method ToNSDictionary: Foundation.NSDictionary<T,U>; inline;
    begin
      result := ToNSMutableDictionary();
    end;

    method ToNSMutableDictionary: Foundation.NSMutableDictionary<T,U>;
    begin
      var lResult := new Foundation.NSMutableDictionary<T,U> withCapacity(Count);
      for each k in Keys do
        lResult[k] := self[k];
      result := lResult;
    end;

    operator Explicit(aDictionary: Foundation.NSDictionary<T,U>): ImmutableDictionary<T,U>;
    begin
      result := new Dictionary<T,U>(aDictionary);
    end;

    operator Explicit(aDictionary: ImmutableDictionary<T,U>): Foundation.NSDictionary<T,U>;
    begin
      result := aDictionary:ToNSDictionary;
    end;

    operator Explicit(aDictionary: ImmutableDictionary<T,U>): Foundation.NSMutableDictionary<T,U>;
    begin
      result := aDictionary:ToNSMutableDictionary;
    end;
    {$ENDIF}

    [&Sequence]
    method GetSequence: sequence of KeyValuePair<T,U>; iterator;
    begin
      for i:Integer := 0 to fMaxUsedIndex-1 do begin
        if fEntriesTable[i].HashCode <> EMPTYHASH then begin
          yield new KeyValuePair<T,U>(fEntriesTable[i].Key,fEntriesTable[i].Value);
        end;
      end;
    end;

    method TryGetValue(aKey: T; out aValue: U): Boolean;
    begin
      var hash := CalcHashCode(aKey);
      var idx := IndexOfKey(hash, aKey);
      if idx <> -1 then begin
        aValue := fEntriesTable[idx].Value;
      end;
      exit idx <> -1;
    end;

    method ContainsKey(Key: T): Boolean;
    begin
      var hash := CalcHashCode(Key);
      exit IndexOfKey(hash,Key) <> -1;
    end;

    method ContainsValue(Value: U): Boolean;
    begin
      exit IndexOfValue(Value) <> -1;
    end;

    method ForEach(Action: Action<KeyValuePair<T, U>>);
    begin
      for i:Integer := 0 to fMaxUsedIndex-1 do begin
        if fEntriesTable[i].HashCode <> EMPTYHASH then begin
          Action(new KeyValuePair<T,U>(fEntriesTable[i].Key,fEntriesTable[i].Value));
        end;
      end;
    end;

    property Item[Key: T]: U read GetItem protected write SetItem; virtual; default;
    property Keys: sequence of T read GetKeys;
    property Values: sequence of U read GetValues;
    property Count: Integer read fCount;
  end;

  Dictionary<T,U> = public class(ImmutableDictionary<T,U>)
  public
    method &Add(Key: T; Value: U);
    begin
      var hash := CalcHashCode(Key);
      if IndexOfKey(hash, Key) <> -1 then raise new Exception('Duplicated key');
      DoAdd(hash, Key,Value);
    end;

    method Clear;
    begin
      fbucketTable := new array of Integer(0);
      fEntriesTable := new array of Entry<T,U>(0);
      fCount := 0;
      fMaxUsedIndex := DEFAULT_MAX_INDEX;
      fFirstHole := EMPTY_BUCKET;
    end;

    method &Remove(Key: T): Boolean;
    begin
      var hash := CalcHashCode(Key);
      var idx := IndexOfKey(hash, Key);
      if idx <> -1 then DoRemove(hash, idx);
      exit idx <> -1;
    end;

    property Item[Key: T]: U read GetItem write SetItem; default; override;

  end;

end.