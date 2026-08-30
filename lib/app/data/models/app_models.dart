// User Role Enum
enum UserRole { b2c, b2b, technician }

// B2C Consultation Chat Message Model
class ChatMessage {
  final String id;
  final String sender; // 'user' or 'cs'
  final String text;
  final String? imagePath;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    this.imagePath,
    required this.timestamp,
  });
}

// B2C Survey Ticket Model
class SurveyTicket {
  final String ticketId;
  final String clientName;
  final String address;
  final String pestType;
  final String areaSize;
  final String surveyorName;
  final String status; // 'Approved', 'Completed', 'Quoted'
  final DateTime scheduledTime;

  SurveyTicket({
    required this.ticketId,
    required this.clientName,
    required this.address,
    required this.pestType,
    required this.areaSize,
    required this.surveyorName,
    required this.status,
    required this.scheduledTime,
  });
}

// B2C Digital Quotation Model
class QuoteItem {
  final String title;
  final String description;
  final double price;

  QuoteItem({
    required this.title,
    required this.description,
    required this.price,
  });
}

class DigitalQuote {
  final String quoteId;
  final String ticketId;
  final double moistureMeterReading;
  final String findings;
  final List<QuoteItem> items;
  final double discountAmount;
  final String promoCode;

  DigitalQuote({
    required this.quoteId,
    required this.ticketId,
    required this.moistureMeterReading,
    required this.findings,
    required this.items,
    this.discountAmount = 0,
    this.promoCode = '',
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.price);
  double get grandTotal => (subtotal - discountAmount).clamp(0, double.infinity);
}

// B2C Warranty Certificate Model
class WarrantyCertificate {
  final String certNumber;
  final String clientName;
  final String propertyAddress;
  final String pestServiceType;
  final DateTime issueDate;
  final DateTime expiryDate;
  final String qrCodeData;
  final bool isActive;

  WarrantyCertificate({
    required this.certNumber,
    required this.clientName,
    required this.propertyAddress,
    required this.pestServiceType,
    required this.issueDate,
    required this.expiryDate,
    required this.qrCodeData,
    this.isActive = true,
  });
}

// Field Technician Job Model
class TechJob {
  final String jobId;
  final String title;
  final String jobType; // 'Free Survey B2C', 'Routine Treatment', 'B2B Escalation'
  final String clientName;
  final String address;
  final String phone;
  final DateTime scheduledTime;
  String status; // 'Pending', 'Navigating', 'In Progress', 'Completed'
  final String zone;

  TechJob({
    required this.jobId,
    required this.title,
    required this.jobType,
    required this.clientName,
    required this.address,
    required this.phone,
    required this.scheduledTime,
    this.status = 'Pending',
    this.zone = 'Zone A',
  });
}
