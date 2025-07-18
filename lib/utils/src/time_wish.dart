String getTimeWish() {
  var now = DateTime.now();
  if (now.hour >= 12 && now.hour < 16) {
    return 'Good Afternoon';
  } else if (now.hour >= 16) {
    return 'Good Evening';
  } else {
    return 'Good Morning';
  }
}
