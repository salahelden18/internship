String statusToString(internStatus) {
  if (internStatus.status == 0) {
    return 'Under review';
  } else if (internStatus.status == 1 &&
      internStatus.insurance.insuranceFile == null) {
    return 'Waiting For SGK';
  } else if (internStatus.status == 1) {
    return 'Approved';
  } else {
    return 'disApproved';
  }
}
