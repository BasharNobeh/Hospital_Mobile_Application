import 'dart:core';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:patient_app/main.dart';

class Language extends ChangeNotifier {
  String _lang = language;

  getLanguage() {
    return _lang;
  }

  setLanguage(String lang) {
    _lang = lang;
    notifyListeners();
  }

  //start of MainScreen for changing lang
  String tPatientAppTitle() {
    if (getLanguage() == 'AR') {
      return "تطبيق المريض";
    } else {
      return "Patient App";
    }
  }

  String tReports() {
    if (getLanguage() == 'AR') {
      return "التقارير";
    } else {
      return "Reports";
    }
  }

  String tMyReports() {
    if (getLanguage() == 'AR') {
      return "تقاريري";
    } else {
      return "My Reports";
    }
  }

  String PhysiciansAndAppointments() {
    if (getLanguage() == 'AR') {
      return "الاطباء و المواعيد";
    } else {
      return "Physicians & Appointments";
    }
  }

  String tAppointments() {
    if (getLanguage() == 'AR') {
      return "المواعيد";
    } else {
      return "Appointments";
    }
  }

  String tMyAppointments() {
    if (getLanguage() == 'AR') {
      return "مواعيدي";
    } else {
      return "My Appointments";
    }
  }

  String tProfile() {
    if (getLanguage() == 'AR') {
      return "الصفحة الشخصية";
    } else {
      return "Profile";
    }
  }

  String tMyProfile() {
    if (getLanguage() == 'AR') {
      return "صفحتي الشخصية";
    } else {
      return "My Profile";
    }
  }
  //end of MainScreen for changing lang

  //start of setting page for changing lang
  String tSettings() {
    if (getLanguage() == 'AR') {
      return "الاعدادات";
    } else {
      return "Settings";
    }
  }

  String tCommon() {
    if (getLanguage() == 'AR') {
      return "الاعتيادي";
    } else {
      return "common";
    }
  }

  String tAreYouSureYouWantLogOut() {
    if (getLanguage() == 'AR') {
      return "هل تريد تسجيل الخروج ؟";
    } else {
      return "Are you sure you want to logout?";
    }
  }

  String tYes() {
    if (getLanguage() == 'AR') {
      return "نعم";
    } else {
      return "Yes";
    }
  }

  String tNo() {
    if (getLanguage() == 'AR') {
      return "لا";
    } else {
      return "No";
    }
  }

  String tLanguage() {
    if (getLanguage() == 'AR') {
      return "تغيير اللغة";
    } else {
      return "Language";
    }
  }

  String tLight() {
    if (getLanguage() == 'AR') {
      return "فاتح";
    } else {
      return "light";
    }
  }

  String tDark() {
    if (getLanguage() == 'AR') {
      return "مظلم";
    } else {
      return "Dark";
    }
  }
//
  String tNotifications() {
    if (getLanguage() == 'AR') {
      return "الاشعارات";
    } else {
      return "Notifications";
    }
  }

  String tEditProfile() {
    if (getLanguage() == 'AR') {
      return "تعديل الحساب";
    } else {
      return "Edit Profile";
    }
  }

  String tChangePassword() {
    if (getLanguage() == 'AR') {
      return "تغيير كلمة السر";
    } else {
      return "Change Password";
    }
  }

  String tLogout() {
    if (getLanguage() == 'AR') {
      return "تسجيل الخروج";
    } else {
      return "Logout";
    }
  }
  //end of setting page for changing lang

  //start of Appointments page for changing lang
  String tScheduledAppointments() {
    if (getLanguage() == 'AR') {
      return "المواعيد المحجوزة";
    } else {
      return "ScheduledAppointments";
    }
  }

  String tNoappointmentsbooked() {
    if (getLanguage() == 'AR') {
      return "لا يوجد لديك مواعيد";
    } else {
      return "No appointments booked!!";
    }
  }

  String tPreviousAppointments() {
    if (getLanguage() == 'AR') {
      return "المواعيد السابقة";
    } else {
      return "Previous Appointments";
    }
  }

  String tIsAlreadyRated() {
    if (getLanguage() == 'AR') {
      return "لقد تم تقييمه من قبل";
    } else {
      return "is already rate it";
    }
  }

  String tViewPreviousAppointments() {
    if (getLanguage() == 'AR') {
      return "تصفح المواعيد السابقة";
    } else {
      return "View Previous Appointments";
    }
  }

  String tDrName() {
    if (getLanguage() == 'AR') {
      return "اسم الدكتور";
    } else {
      return "Dr Name";
    }
  }

  String tDate() {
    if (getLanguage() == 'AR') {
      return "التاريخ";
    } else {
      return "Date";
    }
  }

  String tHour() {
    if (getLanguage() == 'AR') {
      return "الوقت";
    } else {
      return "Hour";
    }
  }
  //end of Appointments page for changing lang

  //start of ChangePassword page for changing lang
  String tChangePasswordPage() {
    if (getLanguage() == 'AR') {
      return "تغيير كلمة السر";
    } else {
      return "Change Password";
    }
  }

  String tNewPassword() {
    if (getLanguage() == 'AR') {
      return "كلمة السر الجديدة";
    } else {
      return "New Password";
    }
  }

  String tEnterNewPassword() {
    if (getLanguage() == 'AR') {
      return "ادخل كلمة السر";
    } else {
      return "Enter New Password";
    }
  }

  String tConfirmNewPassword() {
    if (getLanguage() == 'AR') {
      return "تاكيد كلمة السر";
    } else {
      return "Confirm New Password";
    }
  }

  String tPasswordChanged() {
    if (getLanguage() == 'AR') {
      return "تم التغيير بنجاح";
    } else {
      return "Password Changed";
    }
  }

  String tWrongpasswordentry() {
    if (getLanguage() == 'AR') {
      return "كلمة سر خاطئة";
    } else {
      return "Wrong password entry";
    }
  }

  String tSubmit() {
    if (getLanguage() == 'AR') {
      return "تاكيد";
    } else {
      return "Submit";
    }
  }
  //end of ChangePassword page for changing lang

  //start of DoctorProfile page for changing lang
  String tDoctorProfile() {
    if (getLanguage() == 'AR') {
      return "صفحة الطبيب";
    } else {
      return "Doctor Profile";
    }
  }

  String tExperience() {
    if (getLanguage() == 'AR') {
      return "الخبرة";
    } else {
      return "Experience";
    }
  }

  String tYears() {
    if (getLanguage() == 'AR') {
      return "السنوات";
    } else {
      return "Years";
    }
  }

  String tRating() {
    if (getLanguage() == 'AR') {
      return "التقييم";
    } else {
      return "Rating";
    }
  }

  String tAppointmentbookedsuccessfully() {
    if (getLanguage() == 'AR') {
      return "تم حجز الموعد بنجاح";
    } else {
      return "Appointment booked successfully";
    }
  }

  String tBook() {
    if (getLanguage() == 'AR') {
      return "احجز";
    } else {
      return "Book";
    }
  }
  //end of DoctorProfile page for changing lang

  //start of EditProfile page for changing lang
  String tEditProfileTitle() {
    if (getLanguage() == 'AR') {
      return "تعديل الصفحة الشخصية";
    } else {
      return "Edit Profile";
    }
  }

  String tFirstName() {
    if (getLanguage() == 'AR') {
      return "الاسم الاول";
    } else {
      return "First Name";
    }
  }

  String tEnterFirstName() {
    if (getLanguage() == 'AR') {
      return "ادخل الاسم الاول";
    } else {
      return "Enter First Name";
    }
  }

  String tLastName() {
    if (getLanguage() == 'AR') {
      return "اسم العائلة";
    } else {
      return "Last Name";
    }
  }

  String tEnterLastName() {
    if (getLanguage() == 'AR') {
      return "ادخل اسم العائلة";
    } else {
      return "Enter Last Name";
    }
  }

  String tPhoneNumber() {
    if (getLanguage() == 'AR') {
      return "رقم الهاتف";
    } else {
      return "Phone Number";
    }
  }

  String tEnterPhoneNumber() {
    if (getLanguage() == 'AR') {
      return "ادخل رقم الهاتف";
    } else {
      return "Enter Phone Number";
    }
  }

  String tDateofBirth() {
    if (getLanguage() == 'AR') {
      return "تاريخ الميلاد";
    } else {
      return "Date of Birth";
    }
  }

  String tEnterDateofBirth() {
    if (getLanguage() == 'AR') {
      return "ادخل تاريخ ميلادك";
    } else {
      return "Enter your Date of Birth";
    }
  }

  String tSaved() {
    if (getLanguage() == 'AR') {
      return "تم الحفظ";
    } else {
      return "Saved";
    }
  }

  String tChooseProfilePicture() {
    if (getLanguage() == 'AR') {
      return "اختر صورة شخصية";
    } else {
      return "Choose Profile Picture";
    }
  }

  String tCamera() {
    if (getLanguage() == 'AR') {
      return "الكاميرا";
    } else {
      return "Camera";
    }
  }

  String tGallery() {
    if (getLanguage() == 'AR') {
      return "الستديو";
    } else {
      return "Gallery";
    }
  }

  //end of EditProfile page for changing lang
  //start of ForgotPassword page for changing lang
  String tForgotPassword() {
    if (getLanguage() == 'AR') {
      return "هل نسيت كلمة السر؟";
    } else {
      return "Forgot Password?";
    }
  }

  String tEnterYourEmailForPasswordResetLink() {
    if (getLanguage() == 'AR') {
      return "ادخل بريدك الالكتروني لاستعادة كلمة السر";
    } else {
      return "Enter your email for password reset link";
    }
  }

  String tPasswordResetLinkSentCheckYourEmail() {
    if (getLanguage() == 'AR') {
      return "لقد تم ارسال بريد ! تأكد من بريدك الالكتروني";
    } else {
      return "Password reset link sent! Check your email";
    }
  }

  String ResetPassword() {
    if (getLanguage() == 'AR') {
      return "تغيير كلمة السر";
    } else {
      return "Reset Password";
    }
  }
  //end of ForgotPassword page for changing lang

  //start of LoginScreen page for changing lang
  String tLoginScreenTitle() {
    if (getLanguage() == 'AR') {
      return "تسجيل الدخول";
    } else {
      return "Sign in";
    }
  }

  String tEmail() {
    if (getLanguage() == 'AR') {
      return "البريد الالكتروني";
    } else {
      return "Email";
    }
  }

  String tEnterEmail() {
    if (getLanguage() == 'AR') {
      return "ادخل البريد الالكتروني";
    } else {
      return "Enter Email";
    }
  }

  String tPassword() {
    if (getLanguage() == 'AR') {
      return "كلمة السر";
    } else {
      return "Password";
    }
  }

  String tEnterPassword() {
    if (getLanguage() == 'AR') {
      return "ادخل كلمة السر";
    } else {
      return "Enter Password";
    }
  }

  String tPleaseenterallfields() {
    if (getLanguage() == 'AR') {
      return " الرجاء التأكد من ادخال جميع البيانات";
    } else {
      return "Please enter all fields";
    }
  }

  String tLOGIN() {
    if (getLanguage() == 'AR') {
      return "تسجيل الدخول";
    } else {
      return "LOGIN";
    }
  }

  String tDonthaveanAccount() {
    if (getLanguage() == 'AR') {
      return "لا تملك حساب؟";
    } else {
      return "Don't have an Account?";
    }
  }

  String tSignUp() {
    if (getLanguage() == 'AR') {
      return "سجل من هنا";
    } else {
      return "Sign Up";
    }
  }

  String tGender() {
    if (getLanguage() == 'AR') {
      return "الجنس";
    } else {
      return "Gender";
    }
  }

  //end of LoginScreen page for changing lang

  //start of Physicainas page for changing lang
  String tPhysicainas() {
    if (getLanguage() == 'AR') {
      return "الاطباء";
    } else {
      return "Physicainas";
    }
  }

  String tViewProfile() {
    if (getLanguage() == 'AR') {
      return "تصفح الحساب";
    } else {
      return "View Profile";
    }
  }

  String tSearchbyname() {
    if (getLanguage() == 'AR') {
      return "البحث عن اسم";
    } else {
      return "Search by name";
    }
  }

  String tSearchbyspeciality() {
    if (getLanguage() == 'AR') {
      return "البحث عن تخصص";
    } else {
      return "Search by speciality";
    }
  }
  //end of Physicainas page for changing lang

  //start of Preivous Appointments page for changing lang
  String tPreivousAppointments() {
    if (getLanguage() == 'AR') {
      return "المواعيد السابقة";
    } else {
      return "Preivous Appointments";
    }
  }

  String tNopreivousappointmentsfornow() {
    if (getLanguage() == 'AR') {
      return "لا يوجد مواعيد سابقة";
    } else {
      return "No preivous appointments for now";
    }
  }

  String tDelete() {
    if (getLanguage() == 'AR') {
      return "حذف";
    } else {
      return "Delete";
    }
  }

  String tRate() {
    if (getLanguage() == 'AR') {
      return "التقييم";
    } else {
      return "Rate";
    }
  }
  //end of Preivous Appointments page for changing lang

  //start of Profile page for changing lang
  String tFullName() {
    if (getLanguage() == 'AR') {
      return "اسم المستخدم";
    } else {
      return "Full Name";
    }
  }

  String tEdit() {
    if (getLanguage() == 'AR') {
      return "تعديل";
    } else {
      return "Edit";
    }
  }
  //end of Profile page for changing lang

  //start of Download Report page for changing lang
  String tDownloadReport() {
    if (getLanguage() == 'AR') {
      return "تحميل التقرير";
    } else {
      return "Download Report";
    }
  }

  String tImagehasbeenDownloaded() {
    if (getLanguage() == 'AR') {
      return "تم التنزيل";
    } else {
      return "Image has been Downloaded";
    }
  }
  //end of Download Report page for changing lang

  //start of Report page for changing lang
  String tReportsPage() {
    if (getLanguage() == 'AR') {
      return "التقارير";
    } else {
      return "Reports Page";
    }
  }

  String tHeresWhatsHappeningToday() {
    if (getLanguage() == 'AR') {
      return "ماذا يحدث اليوم؟";
    } else {
      return "Here's What's Happening Today.";
    }
  }

  String tViewRestults() {
    if (getLanguage() == 'AR') {
      return "اظهر النتائج";
    } else {
      return "View Restults";
    }
  }

  String tFindoutmore() {
    if (getLanguage() == 'AR') {
      return "اكتشف المزيد";
    } else {
      return "Find out more";
    }
  }
  //end of Report page for changing lang

  //start of ReportSecondPage for changing lang
  String tReportSecondPage() {
    if (getLanguage() == 'AR') {
      return "تفاصيل التقرير";
    } else {
      return "Detail of Reports";
    }
  }

  String tMyLabatoryResults() {
    if (getLanguage() == 'AR') {
      return "نتائج تحليل المختبر";
    } else {
      return "My Laboratory Results";
    }
  }

  String tDisplayingUpto15Records() {
    if (getLanguage() == 'AR') {
      return "يعرض الان اخر 15 تقرير";
    } else {
      return "Displaying Up to 15 Records";
    }
  }
  //end of ReportSecondPage for changing lang

  //start of SignUpScreen for changing lang
  String tConfirmPassword() {
    if (getLanguage() == 'AR') {
      return "تاكيد كلمة السر";
    } else {
      return "Confirm Password";
    }
  }

  String tReEnterPassword() {
    if (getLanguage() == 'AR') {
      return "اعد ادخال كلمة السر";
    } else {
      return "Re-Enter Password";
    }
  }

  //end of SignUpScreen for changing lang
  String tYoucanOnlybookonetimeevery30minutesPleaseWait() {
    if (getLanguage() == 'AR') {
      return "يمكنك الحجز مره واحده كل 30 دقيقة , الرجاء الانتظار";
    } else {
      return "You can Only book one time every 30 minutes , Please Wait..";
    }
  }

  String Appointmentbookedsuccessfully() {
    if (getLanguage() == 'AR') {
      return "تم حجز الموعد بنجاح";
    } else {
      return "Appointment booked successfully";
    }
  }
}
