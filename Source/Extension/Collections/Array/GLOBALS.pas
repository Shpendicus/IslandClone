namespace GLOBALS;

type
  TIndex = -1..Int64.MaxValue;

	TCapacityLvl = public enum(Low=512, Medium=1024, High=2048) of Int16;

	TMaxCapacity = 0..Int64.MaxValue;

end.