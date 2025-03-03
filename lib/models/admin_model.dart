
class Admincoursemodel {
  final int courseId;
  final String name;
  final String description;

  Admincoursemodel({
    required this.courseId,
    required this.name,
    required this.description,
  });

  factory Admincoursemodel.fromJson(Map<String, dynamic> json) {
  return Admincoursemodel(
    courseId: json['courseId'],
    name: json['title'], // Changed from 'name' to 'title' to match API response
    description: json['description'],
  );
}
}

class AdminModulemodel {
  final int batchId;
  final int moduleId;
  final String title;
  final String content;

  AdminModulemodel({
    required this.batchId,
    required this.moduleId,
    required this.title,
    required this.content,
  });

  // Factory constructor to create a Course instance from JSON
  factory AdminModulemodel.fromJson(Map<String, dynamic> json) {
    return AdminModulemodel(
      batchId: json['batchId'],
      moduleId: json['moduleId'],
      content: json['content'],
      title: json['title'],
    );
  }
}

class AdminLessonmodel {
  final int lessonId;
  final int moduleId;
  final int courseId;
  final int batchId;
  final String title;
  final String content;
  final String videoLink;
  final String? pdfPath; // Nullable
  final String status;

  AdminLessonmodel({
    required this.lessonId,
    required this.moduleId,
    required this.courseId,
    required this.batchId,
    required this.title,
    required this.content,
    required this.videoLink,
    this.pdfPath, // Nullable
    required this.status,
  });

  factory AdminLessonmodel.fromJson(Map<String, dynamic> json) {
    return AdminLessonmodel(
      lessonId: int.parse(json['lessonId']?.toString() ?? '0'),
      moduleId: int.parse(json['moduleId']?.toString() ?? '0'),
      courseId: int.parse(json['courseId']?.toString() ?? '0'),
      batchId: int.parse(json['batchId']?.toString() ?? '0'),
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      videoLink: json['videoLink'] ?? '',
      pdfPath: json['pdfPath'],
      status: json['status'] ?? '',
    );
  }
}

class AdminCourseBatch {
  final int batchId;
  final String batchName;
  final String? medium; // Made nullable
  final DateTime? startTime; // Made nullable
  final DateTime? endTime; // Made nullable

  AdminCourseBatch({
    required this.batchId,
    required this.batchName,
    this.medium,
    this.startTime,
    this.endTime,
  });

  factory AdminCourseBatch.fromJson(Map<String, dynamic> json) {
    return AdminCourseBatch(
      batchId: json['batchId'] ?? 0,
      batchName: json['batchName'] ?? '',
      medium: json['medium'], // Allow null
      startTime:
          json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'batchId': batchId,
      'batchName': batchName,
      'medium': medium,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
    };
  }
}

class AdminAllusersmodel {
  final String name;
  final String email;
  final String phoneNumber;
  final String role;
  final int userId;
  final String? registrationId;

  AdminAllusersmodel(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.role,
      required this.userId,
      required this.registrationId});

  factory AdminAllusersmodel.fromJson(Map<String, dynamic> json) {
    return AdminAllusersmodel(
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        role: json['role'],
        userId: json['userId'],
        registrationId: json['registrationId']);
  }
}

class AdminQuizModel {
  final int quizId;
  final String name;
  final String description;
  final int courseId;
  final int moduleId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Question> questions;

  AdminQuizModel({
    required this.quizId,
    required this.name,
    required this.description,
    required this.courseId,
    required this.moduleId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.questions,
  });

  factory AdminQuizModel.fromJson(Map<String, dynamic> json) {
    return AdminQuizModel(
      quizId: json['quizId'],
      name: json['name'],
      description: json['description'],
      courseId: json['courseId'],
      moduleId: json['moduleId'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      questions: (json['questions'] as List)
          .map((question) => Question.fromJson(question))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quizId': quizId,
      'name': name,
      'description': description,
      'courseId': courseId,
      'moduleId': moduleId,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }
}

class Question {
  final int questionId;
  final String text;
  final List<Answer> answers;

  Question({
    required this.questionId,
    required this.text,
    required this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json['questionId'],
      text: json['text'],
      answers: (json['answers'] as List)
          .map((answer) => Answer.fromJson(answer))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'text': text,
      'answers': answers.map((answer) => answer.toJson()).toList(),
    };
  }
}

class Answer {
  final int answerId;
  final String text;
  final bool? isCorrect; // Make this field nullable

  Answer({
    required this.answerId,
    required this.text,
    this.isCorrect, // Default to null if not provided
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answerId: json['answerId'],
      text: json['text'],
      isCorrect: json['isCorrect'], // This can now be null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answerId': answerId,
      'text': text,
      'isCorrect': isCorrect, // This can be null as well
    };
  }
}

class AssignmentModel {
  final int assignmentId;
  final int courseId;
  final int moduleId;
  final String title;
  final String description;
  final DateTime dueDate;
  final String submissionLink;
  final String status;

  AssignmentModel({
    required this.assignmentId,
    required this.courseId,
    required this.moduleId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.submissionLink,
    required this.status,

    // Default to 'Pending' if not provided
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      assignmentId: json['assignmentId'] ?? 0,
      courseId: json['courseId'] ?? 0,
      moduleId: json['moduleId'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'])
          : DateTime.now(),
      submissionLink: json['submissionLink'] ?? '',
      status: json['status'] ?? 'Pending',
    );
  }
}

class BatchStudentModel {
  final String message;
  final int courseId;
  final String courseName;
  final int batchId;
  final String batchName;
  final List<Student> students;

  BatchStudentModel({
    required this.message,
    required this.courseId,
    required this.courseName,
    required this.batchId,
    required this.batchName,
    required this.students,
  });

  factory BatchStudentModel.fromJson(Map<String, dynamic> json) {
    return BatchStudentModel(
      message: json['message'] as String,
      courseId: json['courseId'] as int,
      courseName: json['courseName'] as String,
      batchId: json['batchId'] as int,
      batchName: json['batchName'] as String,
      students: (json['students'] as List<dynamic>)
          .map((student) => Student.fromJson(student as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Student {
  final int studentId;
  final String name;
  final String email;

  Student({
    required this.studentId,
    required this.name,
    required this.email,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['studentId'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'name': name,
      'email': email,
    };
  }
}

class UserModelstudent {
  final int userId;
  final String? registrationId;
  final String name;
  final String email;
  final String role;
  final List<CourseModel> courses;

  UserModelstudent({
    required this.userId,
    this.registrationId,
    required this.name,
    required this.email,
    required this.role,
    required this.courses,
  });

  factory UserModelstudent.fromJson(Map<String, dynamic> json) {
    var courseList = json['courses'] as List? ?? [];
    List<CourseModel> courses =
        courseList.map((c) => CourseModel.fromJson(c)).toList();

    return UserModelstudent(
      userId: json['userId'],
      registrationId: json['registrationId'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      courses: courses,
    );
  }
}

class CourseModel {
  final int batchId;
  final String? batchName;
  final int courseId;
  final String courseName;

  CourseModel({
    required this.batchId,
    this.batchName,
    required this.courseId,
    required this.courseName,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      batchId: json['batchId'],
      batchName: json['batchName'],
      courseId: json['courseId'],
      courseName: json['courseName'],
    );
  }
}

class UnapprovedUser {
  final int userId;
  final String name;
  final String email;
  final String role;
  final String? phoneNumber; // Added optional phone number field

  UnapprovedUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    this.phoneNumber, // Optional field
  });

  factory UnapprovedUser.fromJson(Map<String, dynamic> json) {
    return UnapprovedUser(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      phoneNumber: json['phoneNumber'], // Parse phone number from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'role': role,
      'phoneNumber': phoneNumber,
    };
  }
}

class UserProfileResponse {
  final String message;
  final UserProfile profile;

  UserProfileResponse({required this.message, required this.profile});

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      message: json['message'],
      profile: UserProfile.fromJson(json['profile']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'profile': profile.toJson(),
    };
  }
}

class UserProfile {
  final int userId; // Changed from id to userId to match API response
  final String name;
  final String email;
  final String role;
  final String phoneNumber;

  UserProfile({
    required this.userId, // Updated parameter name
    required this.name,
    required this.email,
    required this.role,
    required this.phoneNumber,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'], // Updated to match API response
      name: json['name'],
      email: json['email'],
      role: json['role'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId, // Updated field name
      'name': name,
      'email': email,
      'role': role,
      'phoneNumber': phoneNumber,
    };
  }
}

class Submission {
  final int submissionId;
  final int assignmentId;
  final int studentId;
  final String status;
  final String content;
  final DateTime submittedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String studentName;
  final String studentEmail;

  Submission({
    required this.submissionId,
    required this.assignmentId,
    required this.studentId,
    required this.status,
    required this.content,
    required this.submittedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.studentName,
    required this.studentEmail,
  });

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      submissionId: json['submissionId'] ?? 0,
      assignmentId: json['assignmentId'] ?? 0,
      studentId: json['studentId'] ?? 0,
      status: json['status'] ?? '',
      content: json['content'] ?? '',
      submittedAt: DateTime.parse(
          json['submittedAt'] ?? DateTime.now().toIso8601String()),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      studentName: json['Student']?['name'] ?? 'Unknown',
      studentEmail: json['Student']?['email'] ?? 'No email',
    );
  }
}

class QuizSubmission {
  final int submissionId;
  final String studentName;
  final String studentEmail;
  final int quizId;
  final String questionText;
  final String selectedAnswer;
  final bool isCorrect;
  final String status;
  final DateTime submittedAt;

  QuizSubmission({
    required this.submissionId,
    required this.studentName,
    required this.studentEmail,
    required this.quizId,
    required this.questionText,
    required this.selectedAnswer,
    required this.isCorrect,
    required this.status,
    required this.submittedAt,
  });

  factory QuizSubmission.fromMap(Map<String, dynamic> json) {
    return QuizSubmission(
      submissionId: json['submissionId'],
      studentName: json['student']['name'],
      studentEmail: json['student']['email'],
      quizId: json['quizId'],
      questionText: json['question']['text'],
      selectedAnswer: json['selectedAnswer']['text'],
      isCorrect: json['selectedAnswer']['isCorrect'],
      status: json['status'],
      submittedAt: DateTime.parse(json['submittedAt']),
    );
  }
}

class AdminLiveLinkResponse {
  final String message;
  final String liveLink;
  final DateTime liveStartTime;

  AdminLiveLinkResponse({
    required this.message,
    required this.liveLink,
    required this.liveStartTime,
  });

  factory AdminLiveLinkResponse.fromJson(Map<String, dynamic> json) {
    return AdminLiveLinkResponse(
      message: json['message'] as String,
      liveLink: json['liveLink'] as String,
      liveStartTime: DateTime.parse(json['liveStartTime'] as String),
    );
  }
}

class CourseCountsResponse {
  final String message;
  final int courseCount;
  final int batchCount;
  final int studentCount;
  final int teacherCount;
  final List<DetailedCourse> detailedCounts;

  CourseCountsResponse({
    required this.message,
    required this.courseCount,
    required this.batchCount,
    required this.studentCount,
    required this.teacherCount,
    required this.detailedCounts,
  });

  factory CourseCountsResponse.fromJson(Map<String, dynamic> json) {
    return CourseCountsResponse(
      message: json['message'],
      courseCount: json['courseCount'],
      batchCount: json['batchCount'],
      studentCount: json['studentCount'],
      teacherCount: json['teacherCount'],
      detailedCounts: (json['detailedCounts'] as List)
          .map((e) => DetailedCourse.fromJson(e))
          .toList(),
    );
  }
}

class DetailedCourse {
  final int courseId;
  final String courseName;
  final List<Batch> batches;

  DetailedCourse({
    required this.courseId,
    required this.courseName,
    required this.batches,
  });

  factory DetailedCourse.fromJson(Map<String, dynamic> json) {
    return DetailedCourse(
      courseId: json['courseId'],
      courseName: json['courseName'],
      batches: (json['batches'] as List).map((e) => Batch.fromJson(e)).toList(),
    );
  }
}

class Batch {
  final int batchId;
  final String? batchName;
  final int studentCount;

  Batch({
    required this.batchId,
    this.batchName,
    required this.studentCount,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      batchId: json['batchId'],
      batchName: json['batchName'],
      studentCount: json['studentCount'],
    );
  }
}

class BatchTeacherModel {
  final String message;
  final int courseId;
  final String courseName;
  final int batchId;
  final String batchName;
  final List<Teacher> teachers;

  BatchTeacherModel({
    required this.message,
    required this.courseId,
    required this.courseName,
    required this.batchId,
    required this.batchName,
    required this.teachers,
  });

  factory BatchTeacherModel.fromJson(Map<String, dynamic> json) {
    return BatchTeacherModel(
      message: json['message'],
      courseId: json['courseId'],
      courseName: json['courseName'],
      batchId: json['batchId'],
      batchName: json['batchName'],
      teachers: (json['teachers'] as List)
          .map((teacher) => Teacher.fromJson(teacher))
          .toList(),
    );
  }
}

class Teacher {
  final int teacherId;
  final String name;
  final String email;

  Teacher({
    required this.teacherId,
    required this.name,
    required this.email,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      teacherId: json['teacherId'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class UserResponse {
  final String message;
  final User user;

  UserResponse({required this.message, required this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      message: json['message'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user': user.toJson(),
    };
  }
}

class User {
  final int userId;
  final String? registrationId;
  final String name;
  final String email;
  final String role;
  final List<Course> courses;

  User({
    required this.userId,
    this.registrationId,
    required this.name,
    required this.email,
    required this.role,
    required this.courses,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      registrationId: json['registrationId'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      courses: (json['courses'] as List)
          .map((course) => Course.fromJson(course))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'registrationId': registrationId,
      'name': name,
      'email': email,
      'role': role,
      'courses': courses.map((course) => course.toJson()).toList(),
    };
  }

  int get totalSubmittedAssignments {
    return courses.fold(0,
        (sum, course) => sum + (course.assignments?.submittedAssignments ?? 0));
  }

  int get totalSubmittedQuizzes {
    return courses.fold(
        0, (sum, course) => sum + (course.quizzes?.submittedQuizzes ?? 0));
  }
}

class Course {
  final int batchId;
  final String? batchName;
  final int courseId;
  final String courseName;
  final Assignments? assignments;
  final Quizzes? quizzes;

  Course({
    required this.batchId,
    this.batchName,
    required this.courseId,
    required this.courseName,
    this.assignments,
    this.quizzes,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      batchId: json['batchId'],
      batchName: json['batchName'],
      courseId: json['courseId'],
      courseName: json['courseName'],
      assignments: json.containsKey('assignments')
          ? Assignments.fromJson(json['assignments'])
          : null,
      quizzes: json.containsKey('quizzes')
          ? Quizzes.fromJson(json['quizzes'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'batchId': batchId,
      'batchName': batchName,
      'courseId': courseId,
      'courseName': courseName,
      if (assignments != null) 'assignments': assignments!.toJson(),
      if (quizzes != null) 'quizzes': quizzes!.toJson(),
    };
  }
}

class Assignments {
  final int totalAssignments;
  final int submittedAssignments;
  final int pendingAssignments;

  Assignments({
    required this.totalAssignments,
    required this.submittedAssignments,
    required this.pendingAssignments,
  });

  factory Assignments.fromJson(Map<String, dynamic> json) {
    return Assignments(
      totalAssignments: json['totalAssignments'],
      submittedAssignments: json['submittedAssignments'],
      pendingAssignments: json['pendingAssignments'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalAssignments': totalAssignments,
      'submittedAssignments': submittedAssignments,
      'pendingAssignments': pendingAssignments,
    };
  }
}

class Quizzes {
  final int totalQuizzes;
  final int submittedQuizzes;
  final int pendingQuizzes;

  Quizzes({
    required this.totalQuizzes,
    required this.submittedQuizzes,
    required this.pendingQuizzes,
  });

  factory Quizzes.fromJson(Map<String, dynamic> json) {
    return Quizzes(
      totalQuizzes: json['totalQuizzes'],
      submittedQuizzes: json['submittedQuizzes'],
      pendingQuizzes: json['pendingQuizzes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalQuizzes': totalQuizzes,
      'submittedQuizzes': submittedQuizzes,
      'pendingQuizzes': pendingQuizzes,
    };
  }
}

class LeaveRequest {
  int leaveId;
  int studentId;
  DateTime leaveDate;
  String reason;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  Students student; // Ensure this matches the class name

  LeaveRequest({
    required this.leaveId,
    required this.studentId,
    required this.leaveDate,
    required this.reason,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.student,
  });

  factory LeaveRequest.fromJson(Map<String, dynamic> json) => LeaveRequest(
        leaveId: json["id"],
        studentId: json["studentId"],
        leaveDate: DateTime.parse(json["leaveDate"]),
        reason: json["reason"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        student: Students.fromJson(json["student"]), // Fix class name
      );

  Map<String, dynamic> toJson() => {
        "id": leaveId,
        "studentId": studentId,
        "leaveDate":
            "${leaveDate.year.toString().padLeft(4, '0')}-${leaveDate.month.toString().padLeft(2, '0')}-${leaveDate.day.toString().padLeft(2, '0')}",
        "reason": reason,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "student": student.toJson(),
      };
}

class Students {
  int id;
  String name;
  String email;
  int? registrationId; // Change to int? instead of String?

  Students({
    required this.id,
    required this.name,
    required this.email,
    this.registrationId, // Nullable field
  });

  factory Students.fromJson(Map<String, dynamic> json) => Students(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        registrationId: json["registrationId"], // Allow null values
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "registrationId": registrationId, // Keep as null if not present
      };
}


class Bug {
    int id;
    int userId;
    String title;
    String description;
    String status;
    DateTime createdAt;
    DateTime updatedAt;

    Bug({
        required this.id,
        required this.userId,
        required this.title,
        required this.description,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Bug.fromJson(Map<String, dynamic> json) => Bug(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "description": description,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
