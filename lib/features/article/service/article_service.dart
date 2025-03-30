import '../model/article_model.dart';

class ArticleService {
  // In a real app, this would fetch from an API
  // For demo purposes, we'll use mock data
  Future<List<Article>> getArticles() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      Article(
        id: '1',
        title: 'Understanding Takaful Insurance',
        summary:
            'Learn about the principles of Takaful and how it differs from conventional insurance.',
        likesCount: 42,
        thumbsUpCount: 128,
        content: '''
Takaful is an Islamic insurance concept that is based on the principles of mutual cooperation (ta'awun) and donation (tabarru), where risk is shared collectively by a group of participants.

## Key Principles

### 1. Mutual Cooperation
Participants cooperate with each other for their common good.

### 2. Shared Responsibility
Losses are divided and liabilities spread according to the community pooling system.

### 3. Mutual Protection
Takaful provides protection and security against unexpected risk or catastrophe.

### 4. Prohibition of Riba (Interest)
Takaful operates without elements of riba (interest), which is prohibited in Islamic finance.

### 5. Ethical Investments
Contributions are invested in Shariah-compliant businesses and activities.

## Types of Takaful

### Family Takaful
Similar to life insurance, providing protection and long-term savings.

### General Takaful
Covers property, assets, and liabilities against various risks.

### Health Takaful
Provides coverage for medical expenses and healthcare needs.

By understanding these principles, you can make informed decisions about your insurance needs while adhering to Islamic principles.
''',
        imageUrl:
            'https://karryon.com.au/wp-content/uploads/2014/12/shutterstock_120633745.jpg',
        videoUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        // audioUrl: 'https://www.example.com/audio/takaful-principles.mp3',
        publishDate: DateTime(2023, 10, 15),
        author: 'Ahmed Hassan',
        tags: ['Insurance', 'Islamic Finance', 'Takaful'],
      ),
      Article(
        id: '2',
        title: 'The History of Islamic Insurance',
        summary:
            'Explore the rich history of Islamic insurance from its origins to modern implementations.',
        likesCount: 42,
        thumbsUpCount: 128,
        content: '''
# The History of Islamic Insurance

Islamic insurance, known as Takaful, has a rich history dating back to early Islamic civilization. This article explores the evolution of this important financial concept.

## Ancient Origins

The concept of mutual help and shared responsibility has been practiced since the time of the Prophet Muhammad (PBUH). The early Arab tribes had a system called "Aqilah," where members contributed to a fund that would be used to compensate victims of crimes or accidents.

## Medieval Development

During the medieval Islamic period, various forms of mutual assistance evolved:

- **Daman Khatar al-Tariq**: Protection against highway robbery risks for traders
- **Nahd**: A pooling system for travelers to share expenses and risks
- **Waqf**: Endowments that sometimes served insurance-like functions

## Modern Revival

The modern Takaful industry began in the 1970s with the rise of Islamic banking and finance. The first Takaful company was established in Sudan in 1979, followed by others in Malaysia and the Gulf countries.

## Global Growth

Today, Takaful operates in over 75 countries with significant markets in:

- Malaysia
- Saudi Arabia
- UAE
- Indonesia
- Pakistan

## Regulatory Frameworks

Modern Takaful is governed by various regulatory bodies including:

- AAOIFI (Accounting and Auditing Organization for Islamic Financial Institutions)
- IFSB (Islamic Financial Services Board)
- Local regulatory authorities in respective countries

The history of Islamic insurance demonstrates how traditional principles can be adapted to meet contemporary financial needs while maintaining compliance with religious values.
''',
        imageUrl:
            'https://karryon.com.au/wp-content/uploads/2014/12/shutterstock_120633745.jpg',
        //videoUrl:
        //    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        audioUrl:
            'https://sample-files.com/downloads/audio/mp3/sample-files.com_tone_test_audio.mp3',
        publishDate: DateTime(2023, 11, 20),
        author: 'Fatima Al-Zahra',
        tags: ['History', 'Islamic Finance', 'Takaful'],
      ),
      Article(
        id: '3',
        title: '5 Tips for Choosing the Right Takaful Plan',
        summary:
            'Essential advice for selecting a Takaful plan that meets your needs and aligns with your values.',
        likesCount: 42,
        thumbsUpCount: 128,
        content: '''
# 5 Tips for Choosing the Right Takaful Plan

Selecting the appropriate Takaful plan requires careful consideration of various factors. Here are five essential tips to help you make an informed decision.

## 1. Understand Your Coverage Needs

Before selecting a plan, assess your specific requirements:

- **Family protection**: Consider your dependents and their financial needs
- **Asset protection**: Evaluate the value of your property and possessions
- **Health concerns**: Account for potential medical expenses
- **Retirement planning**: Consider long-term savings components

## 2. Verify Shariah Compliance

Ensure the Takaful operator adheres to Islamic principles:

- Check if they have a qualified Shariah advisory board
- Review their investment portfolio for compliance
- Understand how surplus distribution works

## 3. Compare Contribution Rates

Takaful contributions (premiums) can vary significantly between providers:

- Request quotes from multiple operators
- Consider the contribution-to-benefit ratio
- Check for hidden fees or charges

## 4. Evaluate the Operator's Financial Strength

The financial stability of your Takaful provider is crucial:

- Review their credit ratings
- Check their claim settlement ratio
- Assess their re-Takaful arrangements

## 5. Understand the Claims Process

A smooth claims process is essential when you need it most:

- Inquire about the average claim processing time
- Understand required documentation
- Check if they offer digital claim submission

By following these tips, you can select a Takaful plan that not only provides adequate protection but also aligns with your values and financial goals.
''',
        imageUrl:
            'https://karryon.com.au/wp-content/uploads/2014/12/shutterstock_120633745.jpg',
        videoUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        audioUrl:
            'https://sample-files.com/downloads/audio/mp3/sample-files.com_tone_test_audio.mp3',
        publishDate: DateTime(2023, 12, 5),
        author: 'Yusuf Rahman',
        tags: ['Insurance', 'Tips', 'Financial Planning'],
      ),
    ];
  }

  Future<Article?> getArticleById(String id) async {
    final articles = await getArticles();
    try {
      return articles.firstWhere((article) => article.id == id);
    } catch (e) {
      // If article not found, return null instead of throwing an exception
      return null;
    }
  }
}
