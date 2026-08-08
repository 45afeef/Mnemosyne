import '../../../assessment/domain/entities/flashcard.dart';
import '../../../assessment/domain/entities/mcq.dart';
import '../../../learning/domain/entities/learning_content.dart';
import '../../domain/entities/lesson_session.dart';
import '../../domain/entities/session_step.dart';
import '../../domain/entities/topic.dart';

final demoLessonSession = LessonSession(
  id: 'session_1',
  title: 'Introduction to Sales',
  topics: [
    Topic(
      id: 'topic_1',
      title: 'Sales Fundamentals',
      steps: [
        LearningStep(
          id: 'learning_1',
          title: 'What is Sales?',
          content: LearningContent(
            id: 'content_1',
            title: 'What is Sales?',
            markdown: '''
# What is Sales?

Sales is the process of helping customers solve problems by offering products or services that provide value.

Good sales is about understanding customer needs, building trust, and recommending the right solution—not simply convincing someone to buy.

## Key Points

- Sales focuses on solving customer problems.
- Customers buy value, not just products.
- Trust is essential for successful selling.
- Good sales creates long-term relationships.

## Example

A customer wants a laptop for video editing.

Instead of recommending the most expensive model, a good salesperson asks about their budget and software requirements before suggesting the best option.

## Tips

- Listen before talking.
- Focus on customer needs.
- Explain benefits clearly.
- Build trust through honesty.

## Key Takeaway

Sales is about creating value by matching the right solution to the customer's needs.
''',
          ),
        ),

        McqStep(
          id: 'mcq_1',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_1',
            question: 'What is the primary goal of sales?',
            options: [
              McqOption(id: 'a', text: 'Convince everyone to buy'),
              McqOption(id: 'b', text: 'Solve customer problems'),
              McqOption(id: 'c', text: 'Lower product prices'),
              McqOption(id: 'd', text: 'Advertise products'),
            ],
            correctOptionId: 'b',
            explanation:
                'Successful sales focuses on understanding customer needs and providing valuable solutions.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_1',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_1',
            front: 'Sales',
            back:
                'Helping customers solve problems by providing valuable products or services.',
          ),
        ),

        LearningStep(
          id: 'learning_2',
          title: 'Why Customers Buy',
          content: LearningContent(
            id: 'content_2',
            title: 'Why Customers Buy',
            markdown: '''
# Why Customers Buy

Customers don't buy products—they buy solutions to their problems.

People make purchasing decisions based on both logic and emotion.

## Customers Buy Because They Want To

- Solve a problem
- Save time
- Save money
- Feel better
- Reduce risk
- Achieve a goal

## Needs vs Wants

**Need**
Something essential.

**Want**
Something that improves life or brings enjoyment.

## Pain Points

Pain points are problems customers want to eliminate.

Examples:

- Slow software
- High costs
- Poor customer support
- Lack of time

## Key Takeaway

Understanding customer needs is the foundation of successful sales.
''',
          ),
        ),

        McqStep(
          id: 'mcq_2',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_2',
            question: 'Customers usually purchase because they want to:',
            options: [
              McqOption(id: 'a', text: 'Talk to salespeople'),
              McqOption(id: 'b', text: 'Solve a problem'),
              McqOption(id: 'c', text: 'Buy the most expensive item'),
              McqOption(id: 'd', text: 'Follow advertisements'),
            ],
            correctOptionId: 'b',
            explanation:
                'Most purchases are driven by the desire to solve a problem or achieve a goal.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_2',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_2',
            front: 'Pain Point',
            back:
                'A problem, frustration, or challenge that a customer wants to solve.',
          ),
        ),

        LearningStep(
          id: 'learning_3',
          title: 'Sales vs Marketing',
          content: LearningContent(
            id: 'content_3',
            title: 'Sales vs Marketing',
            markdown: '''
# Sales vs Marketing

Sales and marketing work together, but they have different responsibilities.

## Marketing

Marketing attracts potential customers by creating awareness and interest.

Examples:

- Social media
- Advertising
- SEO
- Content marketing
- Email campaigns

## Sales

Sales converts interested prospects into paying customers.

Examples:

- Discovery calls
- Product demonstrations
- Negotiations
- Closing deals

## Simple Analogy

Marketing opens the door.

Sales invites the customer inside.

## Key Takeaway

Marketing generates interest, while sales builds relationships and closes deals.
''',
          ),
        ),

        McqStep(
          id: 'mcq_3',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_3',
            question: 'Marketing primarily focuses on:',
            options: [
              McqOption(id: 'a', text: 'Closing deals'),
              McqOption(id: 'b', text: 'Creating awareness'),
              McqOption(id: 'c', text: 'Handling objections'),
              McqOption(id: 'd', text: 'Negotiating prices'),
            ],
            correctOptionId: 'b',
            explanation:
                'Marketing creates awareness and generates interest, while sales converts prospects into customers.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_3',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_3',
            front: 'Marketing',
            back:
                'Activities that create awareness and attract potential customers.',
          ),
        ),

        LearningStep(
          id: 'learning_4',
          title: 'The Sales Process',
          content: LearningContent(
            id: 'content_4',
            title: 'The Sales Process',
            markdown: '''
# The Sales Process

Most successful sales follow a structured process.

## The Seven Steps

1. Prospecting
2. Qualifying
3. Discovery
4. Presentation
5. Handling Objections
6. Closing
7. Follow-up

## Why It Matters

A repeatable process helps salespeople stay organized and improves customer experience.

## Key Takeaway

Following a structured sales process increases the chances of closing successful deals.
''',
          ),
        ),

        McqStep(
          id: 'mcq_4',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_4',
            question: 'Which stage comes after discovering customer needs?',
            options: [
              McqOption(id: 'a', text: 'Follow-up'),
              McqOption(id: 'b', text: 'Presenting the solution'),
              McqOption(id: 'c', text: 'Prospecting'),
              McqOption(id: 'd', text: 'Customer support'),
            ],
            correctOptionId: 'b',
            explanation:
                'After understanding customer needs, the next step is presenting the most suitable solution.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_4',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_4',
            front: 'Discovery',
            back:
                'The stage where you learn about the customer’s goals, challenges, and needs.',
          ),
        ),

        LearningStep(
          id: 'learning_5',
          title: 'Types of Sales',
          content: LearningContent(
            id: 'content_5',
            title: 'Types of Sales',
            markdown: '''
# Types of Sales

Sales happens in many different environments.

## Common Types

### B2B
Businesses sell to other businesses.

### B2C
Businesses sell directly to consumers.

### Retail Sales
Products sold in physical stores.

### Online Sales
Products sold through websites or apps.

### Inside Sales
Sales conducted remotely via phone or video.

### Field Sales
Sales conducted in person.

## Key Takeaway

Different sales environments require different communication and selling techniques.
''',
          ),
        ),

        McqStep(
          id: 'mcq_5',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_5',
            question: 'Selling software to another company is an example of:',
            options: [
              McqOption(id: 'a', text: 'B2C'),
              McqOption(id: 'b', text: 'B2B'),
              McqOption(id: 'c', text: 'Retail'),
              McqOption(id: 'd', text: 'Inside Marketing'),
            ],
            correctOptionId: 'b',
            explanation:
                'Business-to-Business (B2B) sales occur when one company sells products or services to another company.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_5',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_5',
            front: 'B2B',
            back:
                'Business-to-Business sales where one company sells to another company.',
          ),
        ),
      ],
    ),

    Topic(
      id: 'topic_1',
      title: 'Protecting Yourself Online',
      steps: [
        // 1
        LearningStep(
          id: 'learning_1',
          title: 'What is Cybersecurity?',
          content: LearningContent(
            id: 'content_1',
            title: 'What is Cybersecurity?',
            markdown: '''
# What is Cybersecurity?

Cybersecurity is the practice of protecting computers, mobile devices, networks, and personal information from digital attacks.

Every day we use online banking, social media, shopping websites, and email. Cybersecurity helps keep this information safe from hackers and cybercriminals.

## Why It Matters

- Protects personal information
- Prevents identity theft
- Keeps money safe
- Protects businesses
- Prevents data loss

## Common Threats

- Viruses
- Malware
- Phishing
- Ransomware
- Data breaches

## Key Takeaway

Cybersecurity is about protecting your digital life from online threats.
''',
          ),
        ),

        McqStep(
          id: 'mcq_1',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_1',
            question: 'What is the purpose of cybersecurity?',
            options: [
              McqOption(id: 'a', text: 'Increase internet speed'),
              McqOption(id: 'b', text: 'Protect systems and data'),
              McqOption(id: 'c', text: 'Build websites'),
              McqOption(id: 'd', text: 'Create social media accounts'),
            ],
            correctOptionId: 'b',
            explanation:
                'Cybersecurity protects computers, networks, and personal information from attacks.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_1',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_1',
            front: 'Cybersecurity',
            back:
                'Protecting digital systems and information from cyber threats.',
          ),
        ),

        // 2
        LearningStep(
          id: 'learning_2',
          title: 'Strong Passwords',
          content: LearningContent(
            id: 'content_2',
            title: 'Creating Strong Passwords',
            markdown: '''
# Strong Passwords

A password is your first line of defense.

Weak passwords can be guessed within seconds.

## Tips

- Use at least 12 characters
- Mix uppercase and lowercase letters
- Include numbers
- Include symbols
- Avoid birthdays or names
- Use a different password for every account

Consider using a password manager to securely store passwords.

## Key Takeaway

Long, unique passwords greatly improve account security.
''',
          ),
        ),

        McqStep(
          id: 'mcq_2',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_2',
            question: 'Which password is the strongest?',
            options: [
              McqOption(id: 'a', text: 'password123'),
              McqOption(id: 'b', text: 'John1995'),
              McqOption(id: 'c', text: 'P@8!zQ4#Lm2&'),
              McqOption(id: 'd', text: '12345678'),
            ],
            correctOptionId: 'c',
            explanation:
                'Strong passwords are long, random, and contain different character types.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_2',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_2',
            front: 'Password Manager',
            back: 'A tool that securely stores and generates strong passwords.',
          ),
        ),

        // 3
        LearningStep(
          id: 'learning_3',
          title: 'Recognizing Phishing',
          content: LearningContent(
            id: 'content_3',
            title: 'Recognizing Phishing',
            markdown: '''
# Phishing

Phishing is a scam where attackers pretend to be trusted organizations to steal personal information.

Common examples include fake emails, text messages, and websites.

## Warning Signs

- Urgent messages
- Suspicious links
- Poor grammar
- Requests for passwords
- Unexpected attachments

Always verify before clicking.

## Key Takeaway

Think before you click.
''',
          ),
        ),

        McqStep(
          id: 'mcq_3',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_3',
            question: 'Which is a common sign of phishing?',
            options: [
              McqOption(id: 'a', text: 'Urgent request for your password'),
              McqOption(id: 'b', text: 'Official company newsletter'),
              McqOption(id: 'c', text: 'Software update notification'),
              McqOption(id: 'd', text: 'Calendar reminder'),
            ],
            correctOptionId: 'a',
            explanation:
                'Phishing messages often create urgency to trick victims into sharing sensitive information.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_3',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_3',
            front: 'Phishing',
            back:
                'A fraudulent attempt to steal personal information by pretending to be trustworthy.',
          ),
        ),

        // 4
        LearningStep(
          id: 'learning_4',
          title: 'Two-Factor Authentication',
          content: LearningContent(
            id: 'content_4',
            title: 'Two-Factor Authentication',
            markdown: '''
# Two-Factor Authentication (2FA)

2FA adds another layer of protection.

Even if someone knows your password, they still need a second verification step.

Examples include:

- SMS code
- Authentication app
- Fingerprint
- Face recognition
- Security key

## Key Takeaway

Enable 2FA whenever it is available.
''',
          ),
        ),

        McqStep(
          id: 'mcq_4',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_4',
            question: 'Why is 2FA important?',
            options: [
              McqOption(id: 'a', text: 'It makes the internet faster'),
              McqOption(id: 'b', text: 'It adds an extra layer of security'),
              McqOption(id: 'c', text: 'It replaces passwords'),
              McqOption(id: 'd', text: 'It removes viruses'),
            ],
            correctOptionId: 'b',
            explanation:
                '2FA requires an additional verification method, making unauthorized access much harder.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_4',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_4',
            front: '2FA',
            back:
                'An extra security step that requires a second form of verification.',
          ),
        ),

        // 5
        LearningStep(
          id: 'learning_5',
          title: 'Safe Browsing Habits',
          content: LearningContent(
            id: 'content_5',
            title: 'Safe Browsing Habits',
            markdown: '''
# Safe Browsing

Simple habits can prevent many cyber attacks.

## Best Practices

- Keep software updated.
- Download apps only from trusted sources.
- Avoid suspicious websites.
- Log out of shared computers.
- Back up important files regularly.
- Don't use public Wi-Fi for sensitive transactions unless protected.

## Key Takeaway

Good cybersecurity starts with good daily habits.
''',
          ),
        ),

        McqStep(
          id: 'mcq_5',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_5',
            question: 'Which habit improves online safety?',
            options: [
              McqOption(id: 'a', text: 'Ignoring software updates'),
              McqOption(id: 'b', text: 'Downloading from unknown websites'),
              McqOption(id: 'c', text: 'Keeping software updated'),
              McqOption(id: 'd', text: 'Using the same password everywhere'),
            ],
            correctOptionId: 'c',
            explanation:
                'Updates often include security fixes that protect against newly discovered threats.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_5',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_5',
            front: '2FA',
            back:
                'Two-Factor Authentication adds a second verification step to secure your account.',
          ),
        ),
      ],
    ),

    Topic(
      id: 'topic_1',
      title: 'Week 1: Getting Started',
      steps: [
        LearningStep(
          id: 'learning_1',
          title: 'What is Dropshipping?',
          content: LearningContent(
            id: 'content_1',
            title: 'Understanding Dropshipping',
            markdown: '''
# What is Dropshipping?

Dropshipping is an e-commerce business model where you sell products online without keeping inventory.

When a customer places an order, you purchase the product from a supplier, who then ships it directly to the customer.

You focus on:
- Finding products
- Marketing
- Customer service

The supplier handles:
- Manufacturing
- Storage
- Packaging
- Shipping

---

## Example

Imagine you create an online store selling phone accessories.

A customer buys a phone case for **₹799**.

Your supplier charges **₹450**.

Your gross profit before fees is **₹349**.

---

## Advantages

- Low startup cost
- No inventory required
- Work from anywhere
- Easy to test new products
- Scalable business model

---

## Challenges

- Lower profit margins
- Shipping delays
- Supplier reliability
- Customer support responsibilities

---

## Key Takeaway

Dropshipping lets you start an online business without buying inventory upfront.
''',
          ),
        ),

        McqStep(
          id: 'mcq_1',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_1',
            question: 'Which best describes dropshipping?',
            options: [
              McqOption(id: 'a', text: 'Buying inventory before selling'),
              McqOption(
                id: 'b',
                text: 'Selling products without holding inventory',
              ),
              McqOption(id: 'c', text: 'Running a physical retail shop'),
              McqOption(id: 'd', text: 'Manufacturing your own products'),
            ],
            correctOptionId: 'b',
            explanation:
                'In dropshipping, suppliers store and ship products while you manage sales and customers.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_1',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_1',
            front: 'Dropshipping',
            back:
                'Selling products online without keeping inventory. Suppliers ship directly to customers.',
          ),
        ),

        LearningStep(
          id: 'learning_2',
          title: 'Choose a Profitable Niche',
          content: LearningContent(
            id: 'content_2',
            title: 'Finding Your Niche',
            markdown: '''
# Choose a Profitable Niche

A niche is a specific market you want to serve.

Instead of selling everything, focus on one category.

Examples:

- Fitness products
- Pet accessories
- Home organization
- Kitchen gadgets
- Mobile accessories
- Beauty products

---

## What Makes a Good Niche?

✅ Large demand

✅ Passionate buyers

✅ Affordable shipping

✅ Repeat purchases

✅ Healthy profit margins

---

## Avoid

- Heavy furniture
- Fragile products
- Products with many legal restrictions
- Extremely competitive items

---

## Tip for India

Look for products that solve everyday problems and are priced between **₹500–₹2,500**, where customers are often comfortable buying online.

---

## Key Takeaway

A focused niche makes it easier to attract the right customers and build a recognizable brand.
''',
          ),
        ),

        McqStep(
          id: 'mcq_2',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_2',
            question: 'Why is choosing a niche important?',
            options: [
              McqOption(id: 'a', text: 'It helps target the right customers'),
              McqOption(id: 'b', text: 'It guarantees instant sales'),
              McqOption(id: 'c', text: 'It removes all competition'),
              McqOption(id: 'd', text: 'It eliminates advertising costs'),
            ],
            correctOptionId: 'a',
            explanation:
                'A focused niche helps you market effectively to a specific audience.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_2',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_2',
            front: 'Niche',
            back:
                'A focused group of products aimed at a specific customer audience.',
          ),
        ),

        LearningStep(
          id: 'learning_3',
          title: 'Finding Reliable Suppliers',
          content: LearningContent(
            id: 'content_3',
            title: 'Choosing the Right Supplier',
            markdown: '''
# Finding Reliable Suppliers

Your supplier directly impacts your customer experience.

Look for suppliers that provide:

- Fast shipping
- Quality products
- Responsive communication
- Consistent stock
- Clear return policies

---

## Questions to Ask

- How quickly do they ship?
- What happens if a product is damaged?
- Can they handle increased order volume?
- Do they provide tracking information?

---

## Red Flags

❌ Poor communication

❌ No reviews

❌ Unrealistically low prices

❌ Long processing times

---

## Key Takeaway

A reliable supplier helps you build trust with customers and reduces operational issues.
''',
          ),
        ),

        McqStep(
          id: 'mcq_3',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_3',
            question: 'What is a sign of a reliable supplier?',
            options: [
              McqOption(id: 'a', text: 'Clear communication'),
              McqOption(id: 'b', text: 'No customer reviews'),
              McqOption(id: 'c', text: 'Unknown shipping times'),
              McqOption(id: 'd', text: 'Frequent stock shortages'),
            ],
            correctOptionId: 'a',
            explanation:
                'Reliable suppliers communicate clearly and provide dependable service.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_3',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_3',
            front: 'Supplier',
            back:
                'A business that stores, packages, and ships products to your customers.',
          ),
        ),

        LearningStep(
          id: 'learning_4',
          title: 'Create Your Online Store',
          content: LearningContent(
            id: 'content_4',
            title: 'Building Your Store',
            markdown: '''
# Create Your Online Store

Your online store is your digital shop.

A professional-looking website builds customer trust.

---

## Essentials

- Clear homepage
- Product pages with quality images
- Product descriptions
- Contact page
- Shipping policy
- Return policy
- Secure checkout

---

## Keep It Simple

Avoid clutter.

Use easy navigation and fast-loading pages.

---

## Trust Builders

- Customer reviews
- Secure payment icons
- Frequently Asked Questions
- Contact information

---

## Key Takeaway

A clean, trustworthy website improves the chances of converting visitors into customers.
''',
          ),
        ),

        McqStep(
          id: 'mcq_4',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_4',
            question: 'Which feature helps build trust in an online store?',
            options: [
              McqOption(id: 'a', text: 'Broken product images'),
              McqOption(id: 'b', text: 'Customer reviews'),
              McqOption(id: 'c', text: 'Hidden contact information'),
              McqOption(id: 'd', text: 'Slow-loading pages'),
            ],
            correctOptionId: 'b',
            explanation:
                'Customer reviews and transparent information increase buyer confidence.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_4',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_4',
            front: 'Conversion',
            back:
                'When a visitor completes a desired action, such as making a purchase.',
          ),
        ),

        LearningStep(
          id: 'learning_5',
          title: 'Getting Your First Customers',
          content: LearningContent(
            id: 'content_5',
            title: 'Marketing Your Store',
            markdown: '''
# Getting Your First Customers

Launching your store is only the beginning.

People need to discover your products.

---

## Popular Marketing Channels

- Instagram Reels
- Facebook Ads
- Google Ads
- YouTube Shorts
- Influencer marketing
- SEO
- WhatsApp Business

---

## Content Ideas

- Product demonstrations
- Customer testimonials
- Before & after videos
- Problem-solving videos
- Behind-the-scenes content

---

## Track Performance

Monitor:

- Website visitors
- Conversion rate
- Cost per purchase
- Average order value

These metrics help you improve your marketing over time.

---

## Key Takeaway

Consistent marketing and performance tracking are essential for growing a successful dropshipping business.
''',
          ),
        ),

        McqStep(
          id: 'mcq_5',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_5',
            question:
                'Which marketing channel is useful for showcasing products through short videos?',
            options: [
              McqOption(id: 'a', text: 'Instagram Reels'),
              McqOption(id: 'b', text: 'Spreadsheet software'),
              McqOption(id: 'c', text: 'Calculator'),
              McqOption(id: 'd', text: 'Bluetooth'),
            ],
            correctOptionId: 'a',
            explanation:
                'Short-form video platforms like Instagram Reels are popular for product discovery and demonstrations.',
          ),
        ),

        FlashcardStep(
          id: 'flashcard_5',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_5',
            front: 'Conversion Rate',
            back:
                'The percentage of website visitors who complete a purchase or another desired action.',
          ),
        ),
      ],
    ),
  ],
);
