List<Map<String, DateTime>> getTimeSlots() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = today.add(const Duration(days: 1));

  return [
    {'start': today, 'end': today.add(const Duration(hours: 9))},
    {
      'start': today.add(const Duration(hours: 9)),
      'end': today.add(const Duration(hours: 12)),
    },
    {
      'start': today.add(const Duration(hours: 12)),
      'end': today.add(const Duration(hours: 18)),
    },
    {
      'start': today.add(const Duration(hours: 18)),
      'end': tomorrow, // 00:00 besok
    },
  ];
}

bool isTabOngoing(int tabIndex, {DateTime? now}) {
  now ??= DateTime.now();
  final slots = getTimeSlots();
  if (tabIndex < 0 || tabIndex >= slots.length) return false;

  final slot = slots[tabIndex];
  return now.isAfter(slot['start']!) && now.isBefore(slot['end']!);
}
