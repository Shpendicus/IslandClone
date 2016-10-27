﻿namespace RemObjects.Elements.System;

interface

uses 
  rtl;

type
  atexitfunc = public procedure();
  
  atexitrec = record
  public
    func: atexitfunc;
    next: ^atexitrec;
  end;
  
  ExternalCalls = public static class
  private
    class var atexitlist: ^atexitrec;
  public
    [SymbolName('_elements_posix_exception_handler'), CallingConvention(CallingConvention.Stdcall)] // 32bits windows only!!
    method ExceptionHandler(aVersion: Integer; aState: rtl._Unwind_Action; aClass: UInt64; aEx: ^rtl.__struct__Unwind_Exception; aCtx: ^Void): rtl._Unwind_Reason_Code;
    [SymbolName('ElementsRaiseException')]
    method RaiseException(aRaiseAddress: ^Void; aRaiseFrame: ^Void; aRaiseObject: Object);
    
    const ElementsExceptionCode: UInt64 = $E042881952454d4f;

    [SymbolName('atexit')]
    class method atexit(func: atexitfunc);
    [SymbolName('ElementsBeginCatch')]
    method ElementsBeginCatch(obj: ^Void): ^Void;

    [SymbolName('ElementsEndCatch')]
    method ElementsEndCatch;
    [SymbolName('ElementsGetExceptionForEHData')]
    method GetExceptionForEH(val: ^Void): ^Void;

    [SymbolName('ElementsRethrow')]
    method ElementsRethrow;
    
    [SymbolName('__elements_entry_point')]
    method UserEntryPoint(args: array of String): Integer; external;
    [SYmbolName({$IFDEF EMSCRIPTEN}'_start'{$ELSE}'__elements_entry_point_helper'{$ENDIF})]
    method Entrypoint(argc: Integer; argv: ^^ansichar; envp: ^^ansichar): Integer;
    {$IFNDEF EMSCRIPTEN}
    [SymbolName('_start'), Naked]
    method _start;
    [SymbolName('__libc_start_main', 'libc.so.6')]
    method libc_main(main: LibCEntryHelper; argc: Integer; argv: ^^char; init: LibCEntryHelper; fini: LibCFinalizerHelper); external;
    {$ENDIF}
    [SymbolName('__elements_init')]
    method init(nargs: Integer; args: ^^ansichar; envp: ^^ansichar): Integer;
    [SymbolnAme('__elements_fini')]
    method fini;

    method Parselsda(aAction: rtl._Unwind_Action; aNative: Boolean; aEx: ^rtl.__struct__Unwind_Exception; aCtx: ^Void; 
      out aTypeIndex: rtl.int64_t; out aLandingPadPointer: rtl.uintptr_t): Boolean;
    method DwarfEHReadPointer(var aData: ^Byte; aEncoding: DwarfEHEncodingType): rtl.uintptr_t;
    method DwarfEHReadPointer(var aData: ^Byte): rtl.uintptr_t;
    method DwarfEHReadULEB128(var aData: ^Byte): rtl.uintptr_t;
    method DwarfEHReadSLEB128(var aData: ^Byte): rtl.intptr_t;

    class var nargs: Integer; 
    class var args: ^^ansichar; 
    class var envp: ^^ansichar;
    
    class var
      [SymbolName('__init_array_start')]
      __init_array_start: Integer; external;
      [SymbolName('__init_array_end')]
      __init_array_end: Integer; external;
  end;
  
  DwarfEHEncodingType = public enum (  
    DW_EH_PE_absptr = $00,
    DW_EH_PE_omit = $ff,
    DW_EH_PE_uleb128 = $01,
    DW_EH_PE_udata2 = $02,
    DW_EH_PE_udata4 = $03,
    DW_EH_PE_udata8 = $04,
    DW_EH_PE_sleb128 = $09,
    DW_EH_PE_sdata2 = $0A,
    DW_EH_PE_sdata4 = $0B,
    DW_EH_PE_sdata8 = $0C,
    DW_EH_PE_signed = $08,
    DW_EH_PE_pcrel = $10,
    DW_EH_PE_textrel = $20,
    DW_EH_PE_datarel = $30,
    DW_EH_PE_funcrel = $40,
    DW_EH_PE_aligned = $50,
    DW_EH_PE_indirect = $80) of Byte;
  
  LibCEntryHelper = public method (nargs: Integer; args: ^^ansichar; envp: ^^ansichar): Integer;
  LibCFinalizerHelper = public method();
  
  ElementsException = public record
  public
    handlerSwitchValue: Integer;
    landingPad: rtl.uintptr_t;

    Unwind: rtl.__struct__Unwind_Exception; 
    Object: Object;
  end;

method CheckForLastError(aMessage: String := '');

implementation

method CheckForLastError(aMessage: String := '');
begin
  var code := rtl.errno;
  if code <> 0 then begin
    var mes := (if aMessage <> '' then  aMessage + ', ' else '')+'errno is '+code.ToString;
    raise new Exception(mes);
  end;
end;

method ExternalCalls.RaiseException(aRaiseAddress: ^Void; aRaiseFrame: ^Void; aRaiseObject: Object);
begin
  var lRecord := ^ElementsException(gc.GC_malloc(sizeof(ElementsException))); // we use gc memory for this
  rtl.memset(lRecord, 0, sizeOf(ElementsException));
  var lExp := Exception(aRaiseObject);
  if lExp <> nil then begin
    lExp.ExceptionAddress := aRaiseAddress;
  end;
  
  lRecord^.Unwind.exception_class := ElementsExceptionCode;
  lRecord^.Object := aRaiseObject;
  // No need to set anything, we use a GC so no cleanup needed
  rtl._Unwind_RaiseException(@lRecord^.Unwind);
  writeLn('Uncaught exception: '+aRaiseObject.ToString());
  rtl.exit(-1);
end;

method ExternalCalls. GetExceptionForEH(val: ^Void): ^Void;
begin
  exit InternalCalls.Cast(^ElementsException(val)^.Object);
end;

method ExternalCalls.ExceptionHandler(aVersion: Integer; aState: rtl._Unwind_Action; aClass: UInt64; aEx: ^rtl.__struct__Unwind_Exception; aCtx: ^Void): rtl._Unwind_Reason_Code;
begin
  if (aVersion <> 1) or (aEx = nil) or (aCtx = nil) then exit rtl._Unwind_Reason_Code._URC_FATAL_PHASE1_ERROR;
  var lMine := aClass = ElementsExceptionCode;
  
  var lTypeInfo: rtl.int64_t;
  var lLandingPad: rtl.uintptr_t;
  if 0 <> (aState and rtl.{$IFDEF EMSCRIPTEN}_Unwind_Action.{$ENDIF}_UA_SEARCH_PHASE)  then begin 
    if Parselsda(aState, lMine, aEx, aCtx, out lTypeInfo, out lLandingPad) then begin 
      if lMine then begin 
        var lRecord := ^ElementsException(aEx);
        lRecord := ^ElementsException(@^Byte(lRecord)[-Int32((^Byte(@lRecord^.Unwind) - ^Byte(lRecord)))]);
  
        lRecord^.handlerSwitchValue := lTypeInfo;
        lRecord^.landingPad := lLandingPad;
      end;
      exit rtl._Unwind_Reason_Code._URC_HANDLER_FOUND;
    end;
    exit rtl._Unwind_Reason_Code._URC_CONTINUE_UNWIND;
  end;

  if 0 <> (aState and rtl.{$IFDEF EMSCRIPTEN}_Unwind_Action.{$ENDIF}_UA_CLEANUP_PHASE) then begin 
    // This is either unwinding OR catching
    if (0 = (aState and rtl.{$IFDEF EMSCRIPTEN}_Unwind_Action.{$ENDIF}_UA_HANDLER_FRAME))  then begin 
      // finally, always parse 
      if Parselsda(aState, lMine, aEx, aCtx, out lTypeInfo, out lLandingPad) then begin
        rtl._Unwind_SetGR(aCtx, 0, rtl.uintptr_t(aEx));
        rtl._Unwind_SetGR(aCtx, 1, rtl.uintptr_t(lTypeInfo));
        rtl._Unwind_SetIP(aCtx, lLandingPad);
        exit rtl._Unwind_Reason_Code._URC_INSTALL_CONTEXT;
      end;
      exit rtl._Unwind_Reason_Code._URC_CONTINUE_UNWIND;
    end;
    // exception
    if not lMine then begin 
      if Parselsda(aState, lMine, aEx, aCtx, out lTypeInfo, out lLandingPad) then begin
        rtl._Unwind_SetGR(aCtx, 0, rtl.uintptr_t(aEx));
        rtl._Unwind_SetGR(aCtx, 1, rtl.uintptr_t(lTypeInfo));
        rtl._Unwind_SetIP(aCtx, lLandingPad);
        exit rtl._Unwind_Reason_Code._URC_INSTALL_CONTEXT;
      end;
      // we can't parse the LSDA table and the exception isn't ours, touble.
      exit rtl._Unwind_Reason_Code._URC_FATAL_PHASE1_ERROR;
    end;
    var lRecord := ^ElementsException(aEx);
    lRecord := ^ElementsException(@^Byte(lRecord)[-Int32((^Byte(@lRecord^.Unwind) - ^Byte(lRecord)))]);
    rtl._Unwind_SetGR(aCtx, 0, rtl.uintptr_t(aEx));
    rtl._Unwind_SetGR(aCtx, 1, rtl.uintptr_t(lRecord^.handlerSwitchValue));
    rtl._Unwind_SetIP(aCtx, lRecord^.landingPad);
    exit rtl._Unwind_Reason_Code._URC_INSTALL_CONTEXT;
  end;
  exit rtl._Unwind_Reason_Code._URC_FATAL_PHASE1_ERROR;
end;

method ExternalCalls.ElementsBeginCatch(obj: ^Void): ^Void;
begin
  var lRecord := ^ElementsException(obj);
  lRecord := ^ElementsException(@^Byte(lRecord)[-Int32((^Byte(@lRecord^.Unwind) - ^Byte(lRecord)))]);
  if lRecord^.Unwind.exception_class = ElementsExceptionCode then begin 
    exit InternalCalls.Cast(lRecord^.Object);
  end;
  exit @lRecord^.Object;
end;

method ExternalCalls.ElementsEndCatch;
begin
  // Nothing to see here. but keep it around.
end;

method ExternalCalls.ElementsRethrow;
begin
  // FAIL
end;

{$IFNDEF EMSCRIPTEN}
method ExternalCalls._start;
begin

  InternalCalls.VoidAsm(
    "xor %ebp, %ebp
    movq %rdx, %r9
    popq %rsi
    movq %rsp, %rdx
    and $$0xfffffffffffffff0, %rsp
    pushq %rax
    pushq %rsp
    movq __elements_fini@GOTPCREL(%rip), %r8
    movq __elements_init@GOTPCREL(%rip), %rcx
    movq __elements_entry_point_helper@GOTPCREL(%rip), %rdi
    callq  __libc_start_main
    hlt
  ", "", false, false);
end;
{$ENDIF}
{$HIDE W27}
method ExternalCalls.Entrypoint(argc: Integer; argv: ^^ansichar; envp: ^^ansichar): Integer;
begin
  ExternalCalls.nargs := nargs;
  ExternalCalls.args := args;
  ExternalCalls.envp := envp;
  Utilities.Initialize;
  exit UserEntryPoint([]);
  {$IFNDEF EMSCRIPTEN}
  {$HIDE H14}
  libc_main(nil, 0, nil, nil, nil); // do not remove, this is there to ensure it's linked in.
  {$SHOW H14}
  {$ENDIF}
end;

method ExternalCalls.init(nargs: Integer; args: ^^ansichar; envp: ^^ansichar): Integer;
begin
  var n := (@__init_array_end) - (@__init_array_start);
  for i: Integer := 0 to (n) -1 do begin
    ^LibCEntryHelper(@__init_array_start)[i](nargs, args, envp);
  end;
  exit 0;
end;
{$SHOW W27}
method ExternalCalls.fini;
begin
  //_finilist;
   while atexitlist <> nil do begin
    atexitlist^.func();
    atexitlist := atexitlist^.next;
  end;
  
end;

method ExternalCalls.Parselsda(aAction: _Unwind_Action; aNative: Boolean; aEx: ^__struct__Unwind_Exception; 
  aCtx: ^Void; out aTypeIndex: rtl.int64_t; out aLandingPadPointer: rtl.uintptr_t): Boolean;
begin
  var lLSD := ^Byte(rtl._Unwind_GetLanguageSpecificData(aCtx));
  if lLSD = nil then exit false;
  var lOffset := Integer ((^Byte(rtl._Unwind_GetIP(aCtx)) - ^Byte(rtl._Unwind_GetRegionStart(aCtx)))-1 );
  
  var lLandingPadStart := DwarfEHReadPointer(var lLSD);
  if lLandingPadStart = 0 then lLandingPadStart := uintptr_t(^Byte(rtl._Unwind_GetRegionStart(aCtx)));
  
  var lTypeEncoding := ^DwarfEHEncodingType(lLSD)^;
  inc(lLSD); // skip type info
  var lTypeInfoTable: ^Byte := if lTypeEncoding = DwarfEHEncodingType.DW_EH_PE_omit then nil else DwarfEHReadULEB128(var lLSD) + lLSD; 
  
  var lCallsiteEncoding := ^DwarfEHEncodingType(lLSD)^;
  inc(lLSD);
  var lSizeOfCallsiteTable: UInt32 := uint32_t(DwarfEHReadULEB128(var lLSD));
  var lActionTable: ^uint8_t := lLSD + lSizeOfCallsiteTable;
  loop begin 
    if lLSD >= lActionTable then exit false; // shouldn't  happen; out of range
    var lCallsiteEntryStart: uintptr_t := DwarfEHReadPointer(var lLSD, lCallsiteEncoding);
    var lCallsiteEntryLength: uintptr_t := DwarfEHReadPointer(var lLSD, lCallsiteEncoding);
    aLandingPadPointer := DwarfEHReadPointer(var lLSD, lCallsiteEncoding);
    var lCallsiteEntryActionTable: uintptr_t := DwarfEHReadULEB128(var lLSD);
    if (lOffset >= lCallsiteEntryStart) then begin
      if lOffset >= (lCallsiteEntryStart + lCallsiteEntryLength) then 
        continue; // out of range, an error that shouldn't occur 
      if aLandingPadPointer = 0 then 
        exit false; // nothing to do here, empty LP

      aLandingPadPointer := lLandingPadStart + aLandingPadPointer;

      if lCallsiteEntryActionTable = 0 then begin
        // entry = 0; Cleanup
        if ((aAction and {$IFDEF EMSCRIPTEN}_Unwind_Action.{$ENDIF}_UA_CLEANUP_PHASE) <> 0) and not ((aAction and {$IFDEF EMSCRIPTEN}_Unwind_Action.{$ENDIF}_UA_HANDLER_FRAME) <> 0) then begin
          aTypeIndex := 0;
          exit true;
        end;
        exit false;
      end;

      var lCurrentActionTable: ^uint8_t := lActionTable + lCallsiteEntryActionTable - 1;
      loop begin
        var lIndexInTypeInfoTable: Int64 := DwarfEHReadSLEB128(var lCurrentActionTable);
        if lIndexInTypeInfoTable = 0 then begin 
          // cleanup pad
          if ((aAction and {$IFDEF EMSCRIPTEN}_Unwind_Action.{$ENDIF}_UA_CLEANUP_PHASE) <> 0) and not ((aAction and {$IFDEF EMSCRIPTEN}_Unwind_Action.{$ENDIF}_UA_HANDLER_FRAME) <> 0) then begin
            atypeIndex := lIndexInTypeInfoTable;
            exit true;
          end;
        end;
        if lIndexInTypeInfoTable > 0 then begin
          // this is a catch
          if lTypeInfoTable = nil then exit false; // shouldn't happen
          var lTypeReadOffset := @lTypeInfoTable[- lIndexInTypeInfoTable * case DwarfEHEncodingType(lTypeEncoding and $F) of 
            DwarfEHEncodingType.DW_EH_PE_absptr: sizeof(^byte); 
            DwarfEHEncodingType.DW_EH_PE_udata2, DwarfEHEncodingType.DW_EH_PE_sdata2: 2;
            DwarfEHEncodingType.DW_EH_PE_udata4, DwarfEHEncodingType.DW_EH_PE_sdata4: 4;
            DwarfEHEncodingType.DW_EH_PE_udata8, DwarfEHEncodingType.DW_EH_PE_sdata8: 8;
            else 1;
          end];
          var catchType := ^void(DwarfEHReadPointer(var lTypeReadOffset, lTypeEncoding));
          if catchType = nil then begin
            // catch all 
            if ((aAction and {$IFDEF EMSCRIPTEN}_Unwind_Action.{$ENDIF}_UA_SEARCH_PHASE) <> 0) or ((aAction and {$IFDEF EMSCRIPTEN}_Unwind_Action.{$ENDIF}_UA_HANDLER_FRAME) <>0) then begin
              atypeIndex := lIndexInTypeInfoTable;
              exit true;
            end
            else begin
              // Unexpected but we exit continueing thee search
              exit false;
            end;
          end;

          if aNative then begin
            var exception_header := ^ElementsException(aEx);
            exception_header := ^ElementsException(@^Byte(exception_header)[-Int32((^Byte(@exception_header^.Unwind) - ^Byte(exception_header)))]);

            if Utilities.IsInstance(exception_header^.Object, catchType) <> nil then begin
              if 0 <> (aAction and {$IFDEF EMSCRIPTEN}_Unwind_Action.{$ENDIF}_UA_SEARCH_PHASE) then begin
                atypeIndex := lIndexInTypeInfoTable;
                exit true;
              end
              else begin
                if 0 = (aAction and {$IFDEF EMSCRIPTEN}_Unwind_Action.{$ENDIF}_UA_FORCE_UNWIND) then begin
                  //call_terminate(native_exception, unwind_exception);
                  exit false;
                end;
              end;
            end; 
          end;

        end;
        var temp: ^uint8_t := lCurrentActionTable;
        var actionOffset: Int64 := DwarfEHReadSLEB128(var temp);
        if actionOffset = 0 then begin
          exit false;
        end;
        lCurrentActionTable := lCurrentActionTable + actionOffset;
      end;
    end
  end;
end;

method ExternalCalls.DwarfEHReadPointer(var aData: ^Byte; aEncoding: DwarfEHEncodingType): uintptr_t;
begin
  var lStart := @aData;
  case DwarfEHEncodingType(aEncoding and $f) of 
    (DwarfEHEncodingType.DW_EH_PE_omit and $f): exit 0;
    DwarfEHEncodingType.DW_EH_PE_absptr: begin 
      result := ^rtl.uintptr_t(aData)^;
      inc(aData, sizeOf(rtl.uintptr_t));
    end;
    DwarfEHEncodingType.DW_EH_PE_uleb128: result := DwarfEHReadULEB128(var aData);
    DwarfEHEncodingType.DW_EH_PE_sleb128: result := DwarfEHReadSLEB128(var aData);
    DwarfEHEncodingType.DW_EH_PE_sdata2, 
    DwarfEHEncodingType.DW_EH_PE_udata2: begin 
      result := ^rtl.uint16_t(aData)^;
    inc(aData, 2);
    end;
    DwarfEHEncodingType.DW_EH_PE_udata4,
    DwarfEHEncodingType.DW_EH_PE_sdata4: begin 
      result := ^rtl.uint32_t(aData)^;
    inc(aData, 4);
    end;
    DwarfEHEncodingType.DW_EH_PE_udata8,
    DwarfEHEncodingType.DW_EH_PE_sdata8: begin 
      result := ^rtl.uint64_t(aData)^;
    inc(aData, 8);
    end;
  else exit 0;
  end;
  if 0  <> (aEncoding and DwarfEHEncodingType.DW_EH_PE_pcrel) then 
    result := result + rtl.uintptr_t(lStart);
  if 0 <> (aEncoding and DwarfEHEncodingType.DW_EH_PE_indirect) then
    result := ^uintptr_t(result)^;
end;

method ExternalCalls.DwarfEHReadPointer(var aData: ^Byte): uintptr_t;
begin
  var lEncoding: DwarfEHEncodingType := ^DwarfEHEncodingType(aData)^;
  inc(aData);
  exit DwarfEHReadPointer(var aData, lEncoding);
end;

method ExternalCalls.DwarfEHReadULEB128(var aData: ^Byte): uintptr_t;
begin
  var lShift := 0;
  loop begin 
    var lData := aData^;
    inc(aData);
    result := result or (rtl.uintptr_t(lData and $7f) shl lShift);
    if (lData and $80) = 0 then break;
    lShift := lShift + 7;
  end;
end;

method ExternalCalls.DwarfEHReadSLEB128(var aData: ^Byte): intptr_t;
begin
  var lShift := 0;
  loop begin 
    var lData := aData^;
    inc(aData);
    result := result or (rtl.uintptr_t(lData and $7f) shl lShift);
    lShift := lShift + 7;
    if (lData and $80) = 0 then break;
  end;
  if ((aData[-1] and $40) <> 0) and (lShift < sizeOf(intptr_t)) then 
    result := result or - (intptr_t(1) shl lShift);
end;

method ExternalCalls.atexit(func: atexitfunc);
begin
  var rec := ^atexitrec(gc.GC_malloc(sizeOf(atexitrec)));
  // TODO: make atomic
  rec^.func := func;
  rec^.next := atexitlist;
  atexitlist := rec;
end;

end.
