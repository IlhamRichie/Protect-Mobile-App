import 'package:flutter/material.dart';

enum SeverityLevel { critical, warning, info }
enum IncidentStatus { activeBreach, resolving, resolved }
enum OrderStatus { pending, enRoute, inProgress, completed, cancelled }
enum JobStatus { assigned, inProgress, completed }

class ServiceItem {
  final String id;
  final String title;
  final String subtitle;
  final int price;
  final String description;

  const ServiceItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.description,
  });
}

class IncidentItem {
  final String id;
  final String code;
  final String title;
  final String timestamp;
  final String location;
  final SeverityLevel severity;
  IncidentStatus status;
  final int confidence;
  final String species;
  final String cameraName;
  final String detectionZone;
  String recommendedAction;

  IncidentItem({
    required this.id,
    required this.code,
    required this.title,
    required this.timestamp,
    required this.location,
    required this.severity,
    required this.status,
    required this.confidence,
    required this.species,
    required this.cameraName,
    required this.detectionZone,
    required this.recommendedAction,
  });
}

class OrderItem {
  final String id;
  final String orderNumber;
  final String serviceTitle;
  final OrderStatus status;
  final String date;
  final String time;
  final String address;
  final int price;
  final String technicianName;
  final String warrantyUntil;

  const OrderItem({
    required this.id,
    required this.orderNumber,
    required this.serviceTitle,
    required this.status,
    required this.date,
    required this.time,
    required this.address,
    required this.price,
    required this.technicianName,
    required this.warrantyUntil,
  });
}

class TechnicianJob {
  final String id;
  final String code;
  final String clientName;
  final String address;
  final String serviceType;
  final String pestType;
  final String severity;
  JobStatus status;
  final String scheduleTime;
  final String phone;
  final String notes;

  TechnicianJob({
    required this.id,
    required this.code,
    required this.clientName,
    required this.address,
    required this.serviceType,
    required this.pestType,
    required this.severity,
    required this.status,
    required this.scheduleTime,
    required this.phone,
    required this.notes,
  });
}

class ArticleItem {
  final String id;
  final String title;
  final String snippet;
  final String category;
  final String readTime;
  final String date;

  const ArticleItem({
    required this.id,
    required this.title,
    required this.snippet,
    required this.category,
    required this.readTime,
    required this.date,
  });
}

class CameraItem {
  final String id;
  final String name;
  final String rtspUrl;
  final String location;
  final String status;
  final int fps;
  final String resolution;
  double sensitivity;
  bool isAiActive;

  CameraItem({
    required this.id,
    required this.name,
    required this.rtspUrl,
    required this.location,
    required this.status,
    required this.fps,
    required this.resolution,
    required this.sensitivity,
    required this.isAiActive,
  });
}

class EsgMetric {
  final String label;
  final String value;
  final String change;
  final String unit;
  final bool isPositive;

  const EsgMetric({
    required this.label,
    required this.value,
    required this.change,
    required this.unit,
    required this.isPositive,
  });
}

class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final String timestamp;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
