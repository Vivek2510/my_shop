
extension TimeAgo on DateTime {
  // String get timeAgo {
  //   final now = DateTime.now();
  //   final today = DateTime(now.year, now.month, now.day);
  //
  //   var diff = today.difference(this);
  //   if (diff.inDays > 365) {
  //     return '${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? MessageConstant.year : MessageConstant.years} ${MessageConstant.ago}';
  //   }
  //   if (diff.inDays > 30) {
  //     return '${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? MessageConstant.month : MessageConstant.months} ${MessageConstant.ago}';
  //   }
  //   if (diff.inDays > 7) {
  //     return '${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? MessageConstant.week : MessageConstant.weeks} ${MessageConstant.ago}';
  //   }
  //   if (diff.inDays > 0) {
  //     return '${diff.inDays} ${diff.inDays == 1 ? MessageConstant.day : MessageConstant.days} ${MessageConstant.ago}';
  //   }
  //
  //   final timeDiff = now.difference(this);
  //   if (timeDiff.inHours > 0) {
  //     return '${timeDiff.inHours} ${timeDiff.inHours == 1 ? MessageConstant.hour : MessageConstant.hours} ${MessageConstant.ago}';
  //   }
  //   if (timeDiff.inMinutes > 0) {
  //     return '${timeDiff.inMinutes} ${timeDiff.inMinutes == 1 ? MessageConstant.minute : MessageConstant.minutes} ${MessageConstant.ago}';
  //   }
  //   return MessageConstant.justNow;
  // }

}
