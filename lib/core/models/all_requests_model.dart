class AllRequestsDataModel {
  AllRequestsDataModel({
    required this.corrNumber,
    required this.requestReplyDate,
    required this.corrDeliveryDate,
    required this.corrCategoryTypeNavigation,
    required this.reqStatusNavigation,
    // required this.corrId,
    // required this.corrTitle,
    // required this.corrSiteId,
    // required this.corrCreateDate,
    // required this.fDeleted,
    // required this.fDestroy,
    // required this.folderPath,
    // required this.cancelDate,
    // required this.cancelReason,
    // required this.fRouted,
    // required this.routeDate,
    // required this.paymentAmount,
    // required this.paymentRefrenceNo,
    // required this.paymentDate,
    // required this.fPayment,
    // required this.fMig,
    // required this.fRequestDoneStatus,
    // required this.lastModifiedby,
    // required this.companyReplayDate,
    // required this.requestExpiryDate,
  });

  late final String corrNumber;
  late final String requestReplyDate;
  late final String corrDeliveryDate;
  late final CorrCategoryTypeNavigation corrCategoryTypeNavigation;
   CitizenReplyDetailsNavigation? citizenReplyDetailsNavigation;
  late final ReqStatusNavigation reqStatusNavigation;

  // late final num corrId;
  // late final dynamic corrTitle;
  // late final num corrSiteId;
  // late final String corrCreateDate;
  // late final num fDeleted;
  // late final num fDestroy;
  // late final String folderPath;
  // late final dynamic cancelDate;
  // late final dynamic cancelReason;
  // late final num fRouted;
  // late final String routeDate;
  // late final num paymentAmount;
  // late final num paymentRefrenceNo;
  // late final String paymentDate;
  // late final num fPayment;
  // late final num fMig;
  // late final dynamic fRequestDoneStatus;
  // late final dynamic lastModifiedby;
  // late final String companyReplayDate;
  // late final dynamic lastRequestStatusDate;
  // late final dynamic requestExpiryDate;

  AllRequestsDataModel.fromJson(Map<String, dynamic> json) {
    corrNumber = json['corrNumber'] ?? '';
    requestReplyDate = json['requestReplyDate'] ?? '';
    corrDeliveryDate = json['corrDeliveryDate'] ?? '';
    if (json['corrCategoryTypeNavigation'] != null) {
      corrCategoryTypeNavigation = CorrCategoryTypeNavigation.fromJson(
          json['corrCategoryTypeNavigation']);
    }

    if (json['citizenReplyDetailsNavigation'] != null) {
      citizenReplyDetailsNavigation = CitizenReplyDetailsNavigation.fromJson(
          json['citizenReplyDetailsNavigation']);
    }

    if (json['reqStatusNavigation'] != null) {
      reqStatusNavigation =
          ReqStatusNavigation.fromJson(json['reqStatusNavigation']);
    }

    // corrId = json['corrId'] ?? 0;
    // corrTitle = json['corrTitle'] ?? '';
    // corrSiteId = json['corrSiteId'] ?? 0;
    // corrCreateDate = json['corrCreateDate'] ?? '';
    // fDeleted = json['fDeleted'] ?? 0;
    // fDestroy = json['fDestroy'] ?? 0;
    // folderPath = json['folderPath'] ?? '';
    // cancelDate = json['cancelDate'] ?? '';
    // cancelReason = json['cancelReason'] ?? '';
    // fRouted = json['fRouted'] ?? 0;
    // routeDate = json['routeDate'] ?? '';
    // paymentAmount = json['paymentAmount'] ?? 0;
    // paymentRefrenceNo = json['paymentRefrenceNo'] ?? 0;
    // paymentDate = json['paymentDate'] ?? '';
    // fPayment = json['fPayment'] ?? 0;
    // fMig = json['fMig'] ?? 0;
    // fRequestDoneStatus = json['fRequestDoneStatus'] ?? '';
    // lastModifiedby = json['lastModifiedby'] ?? '';
    // companyReplayDate = json['companyReplayDate'] ?? '';
    // lastRequestStatusDate = json['lastRequestStatusDate'] ?? '';
    // requestExpiryDate = json['requestExpiryDate'] ?? '';
  }
}

class CorrCategoryTypeNavigation {
  CorrCategoryTypeNavigation({
    required this.ename,
    required this.aname,
  });

  late final String ename;
  late final String aname;
   CategoryParent? categoryParent;

// late final num id;
// late final dynamic code;
// late final num categoryParentId;
// late final String edescription;
// late final String adescription;
// late final num orderby;
// late final num isdeleted;
// late final dynamic workflowTypeId;
// late final dynamic replydays;
// late final num fService;
// late final num fMig;
// late final num fDelete;
// late final dynamic categoryApplicationId;
// late final String datemodified;
// late final num modifiedby;
// late final num fPublish;
// late final String weeklyDays;
//
// late final num limitaion;
// late final num limitationPerCompany;
// late final String reportProcedureName;
// late final dynamic excpectedDoneDays;
// late final dynamic vacancyPermission;
// late final bool isPaidRequest;
// late final String categotyImagePath;

  CorrCategoryTypeNavigation.fromJson(Map<String, dynamic> json) {
    ename = json['ename'] ?? '';
    aname = json['aname'] ?? '';

    if(json['categoryParent'] != null){
      categoryParent = CategoryParent.fromJson(json['categoryParent']);
    }
  }
}

class CitizenReplyDetailsNavigation {
  CitizenReplyDetailsNavigation({
    required this.requiredComment,
    required this.attendenceDate,
  });

  late final String requiredComment;
  late final String attendenceDate;

  CitizenReplyDetailsNavigation.fromJson(Map<String, dynamic> json) {
    requiredComment = json['requiredComment'] ?? '';
    attendenceDate = json['attendenceDate'] ?? '';
  }
}

class ReqStatusNavigation {
  ReqStatusNavigation({
    required this.description,
  });

  late final String description;

  ReqStatusNavigation.fromJson(Map<String, dynamic> json) {
    description = json['description'] ?? '';
  }
}

class CategoryParent {
  CategoryParent({
    required this.ename,
    required this.aname,
  });

  late final String ename;
  late final String aname;

  CategoryParent.fromJson(Map<String, dynamic> json) {
    ename = json['ename'] ?? '';
    aname = json['aname'] ?? '';
  }
}


// class TimeModelValue {
// late final num ticks;
// late final num days;
// late final num hours;
// late final num milliseconds;
// late final num minutes;
// late final num seconds;
// late final num totalDays;
// late final num totalHours;
// late final num totalMilliseconds;
// late final num totalMinutes;
// late final num totalSeconds;
// }
