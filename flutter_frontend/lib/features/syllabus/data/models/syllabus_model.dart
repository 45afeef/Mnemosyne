import '../../domain/entities/syllabus.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/module.dart';
import '../../domain/entities/learning_item.dart';

class SyllabusModel extends Syllabus {
  const SyllabusModel({
    required super.id,
    required super.title,
    required super.description,
    required super.subjects,
  });

  factory SyllabusModel.dummy(String id) {
    return SyllabusModel(
      id: id,
      title: "Advanced Marketing Manager Interview Preparation",
      description:
          "Prepare for an Advanced Marketing Manager interview by mastering strategic marketing, leadership, analytics, and executive communication.",
      subjects: [
        Subject(
          id: "subject_1",
          name: "Strategic Marketing Leadership",
          order: 1,
          modules: [
            Module(
              id: "module_1_1",
              name: "Marketing Strategy Fundamentals",
              order: 1,
              learningItems: [
                LearningItem(
                  id: "item_1_1_1",
                  title: "Business Goal Alignment",
                  description:
                      "Connect marketing initiatives to business objectives.",
                  order: 1,
                ),
                LearningItem(
                  id: "item_1_1_2",
                  title: "Market Segmentation",
                  description:
                      "Identify and prioritize target customer segments.",
                  order: 2,
                ),
                LearningItem(
                  id: "item_1_1_3",
                  title: "Competitive Positioning",
                  description: "Build differentiated value propositions.",
                  order: 3,
                ),
                LearningItem(
                  id: "item_1_1_4",
                  title: "Go-to-Market Strategy",
                  description:
                      "Plan successful product launches and campaigns.",
                  order: 4,
                ),
                LearningItem(
                  id: "item_1_1_5",
                  title: "Marketing Planning",
                  description:
                      "Create annual and quarterly marketing roadmaps.",
                  order: 5,
                ),
              ],
            ),
            Module(
              id: "module_1_2",
              name: "Brand Management",
              order: 2,
              learningItems: [
                LearningItem(
                  id: "item_1_2_1",
                  title: "Brand Identity",
                  description: "Develop consistent brand messaging.",
                  order: 1,
                ),
                LearningItem(
                  id: "item_1_2_2",
                  title: "Brand Equity",
                  description: "Measure and improve brand value.",
                  order: 2,
                ),
                LearningItem(
                  id: "item_1_2_3",
                  title: "Customer Value Proposition",
                  description: "Communicate compelling customer benefits.",
                  order: 3,
                ),
                LearningItem(
                  id: "item_1_2_4",
                  title: "Brand Architecture",
                  description: "Manage multi-brand portfolios.",
                  order: 4,
                ),
                LearningItem(
                  id: "item_1_2_5",
                  title: "Rebranding Strategy",
                  description: "Plan and execute successful rebranding.",
                  order: 5,
                ),
              ],
            ),
            Module(
              id: "module_1_3",
              name: "Growth Strategy",
              order: 3,
              learningItems: [
                LearningItem(
                  id: "item_1_3_1",
                  title: "Growth Frameworks",
                  description: "Apply growth models to marketing.",
                  order: 1,
                ),
                LearningItem(
                  id: "item_1_3_2",
                  title: "Market Expansion",
                  description: "Evaluate new market opportunities.",
                  order: 2,
                ),
                LearningItem(
                  id: "item_1_3_3",
                  title: "Product Lifecycle",
                  description: "Optimize marketing across lifecycle stages.",
                  order: 3,
                ),
                LearningItem(
                  id: "item_1_3_4",
                  title: "Pricing Strategy",
                  description:
                      "Support pricing decisions with market insights.",
                  order: 4,
                ),
                LearningItem(
                  id: "item_1_3_5",
                  title: "Revenue Growth Planning",
                  description: "Build initiatives that increase revenue.",
                  order: 5,
                ),
              ],
            ),
            Module(
              id: "module_1_4",
              name: "Interview Strategy Questions",
              order: 4,
              learningItems: [
                LearningItem(
                  id: "item_1_4_1",
                  title: "Marketing Case Studies",
                  description: "Analyze real-world business scenarios.",
                  order: 1,
                ),
                LearningItem(
                  id: "item_1_4_2",
                  title: "Strategic Thinking Questions",
                  description: "Answer complex business strategy questions.",
                  order: 2,
                ),
                LearningItem(
                  id: "item_1_4_3",
                  title: "Campaign Planning Exercises",
                  description: "Design end-to-end campaign strategies.",
                  order: 3,
                ),
                LearningItem(
                  id: "item_1_4_4",
                  title: "Executive Decision Making",
                  description: "Explain strategic trade-offs confidently.",
                  order: 4,
                ),
                LearningItem(
                  id: "item_1_4_5",
                  title: "Business Impact Storytelling",
                  description: "Present measurable business outcomes.",
                  order: 5,
                ),
              ],
            ),
          ],
        ),
        Subject(
          id: "subject_2",
          name: "Performance Marketing and Analytics",
          order: 2,
          modules: [
            Module(
              id: "module_2_1",
              name: "Marketing Analytics",
              order: 1,
              learningItems: [
                LearningItem(
                  id: "item_2_1_1",
                  title: "Key Marketing KPIs",
                  description: "Measure campaign and business performance.",
                  order: 1,
                ),
                LearningItem(
                  id: "item_2_1_2",
                  title: "Attribution Models",
                  description: "Understand multi-touch attribution.",
                  order: 2,
                ),
                LearningItem(
                  id: "item_2_1_3",
                  title: "Customer Lifetime Value",
                  description: "Calculate and optimize CLV.",
                  order: 3,
                ),
                LearningItem(
                  id: "item_2_1_4",
                  title: "Marketing Dashboards",
                  description: "Build executive performance reports.",
                  order: 4,
                ),
                LearningItem(
                  id: "item_2_1_5",
                  title: "Data Interpretation",
                  description: "Generate actionable business insights.",
                  order: 5,
                ),
              ],
            ),
            Module(
              id: "module_2_2",
              name: "Digital Marketing Excellence",
              order: 2,
              learningItems: [
                LearningItem(
                  id: "item_2_2_1",
                  title: "SEO Strategy",
                  description: "Improve organic search visibility.",
                  order: 1,
                ),
                LearningItem(
                  id: "item_2_2_2",
                  title: "Paid Media Strategy",
                  description: "Optimize advertising investments.",
                  order: 2,
                ),
                LearningItem(
                  id: "item_2_2_3",
                  title: "Content Marketing",
                  description: "Develop content that drives engagement.",
                  order: 3,
                ),
                LearningItem(
                  id: "item_2_2_4",
                  title: "Email Marketing",
                  description: "Increase customer retention and conversions.",
                  order: 4,
                ),
                LearningItem(
                  id: "item_2_2_5",
                  title: "Social Media Leadership",
                  description: "Lead social media strategy across channels.",
                  order: 5,
                ),
              ],
            ),
            Module(
              id: "module_2_3",
              name: "Optimization Techniques",
              order: 3,
              learningItems: [
                LearningItem(
                  id: "item_2_3_1",
                  title: "A/B Testing",
                  description: "Design statistically valid experiments.",
                  order: 1,
                ),
                LearningItem(
                  id: "item_2_3_2",
                  title: "Conversion Rate Optimization",
                  description: "Increase website conversion performance.",
                  order: 2,
                ),
                LearningItem(
                  id: "item_2_3_3",
                  title: "Funnel Analysis",
                  description: "Identify customer journey bottlenecks.",
                  order: 3,
                ),
                LearningItem(
                  id: "item_2_3_4",
                  title: "Budget Optimization",
                  description: "Allocate spend for maximum ROI.",
                  order: 4,
                ),
                LearningItem(
                  id: "item_2_3_5",
                  title: "Marketing Automation",
                  description: "Scale campaigns using automation.",
                  order: 5,
                ),
              ],
            ),
            Module(
              id: "module_2_4",
              name: "Interview Analytics Questions",
              order: 4,
              learningItems: [
                LearningItem(
                  id: "item_2_4_1",
                  title: "ROI Calculation",
                  description: "Explain marketing return on investment.",
                  order: 1,
                ),
                LearningItem(
                  id: "item_2_4_2",
                  title: "Campaign Performance Review",
                  description: "Evaluate campaign success using metrics.",
                  order: 2,
                ),
                LearningItem(
                  id: "item_2_4_3",
                  title: "Dashboard Presentation",
                  description: "Present executive-level performance reports.",
                  order: 3,
                ),
                LearningItem(
                  id: "item_2_4_4",
                  title: "Data-Driven Recommendations",
                  description: "Recommend improvements from data.",
                  order: 4,
                ),
                LearningItem(
                  id: "item_2_4_5",
                  title: "Problem Solving Scenarios",
                  description: "Solve marketing performance challenges.",
                  order: 5,
                ),
              ],
            ),
          ],
        ),
        Subject(
          id: "subject_3",
          name: "Leadership and Interview Excellence",
          order: 3,
          modules: [
            Module(
              id: "module_3_1",
              name: "Leadership Skills",
              order: 1,
              learningItems: [
                LearningItem(
                  id: "item_3_1_1",
                  title: "Team Leadership",
                  description: "Build and motivate marketing teams.",
                  order: 1,
                ),
                LearningItem(
                  id: "item_3_1_2",
                  title: "Stakeholder Management",
                  description:
                      "Influence executives and cross-functional partners.",
                  order: 2,
                ),
                LearningItem(
                  id: "item_3_1_3",
                  title: "Conflict Resolution",
                  description: "Handle team disagreements effectively.",
                  order: 3,
                ),
                LearningItem(
                  id: "item_3_1_4",
                  title: "Performance Coaching",
                  description: "Develop marketing talent.",
                  order: 4,
                ),
                LearningItem(
                  id: "item_3_1_5",
                  title: "Change Management",
                  description: "Lead organizational transformation.",
                  order: 5,
                ),
              ],
            ),
            Module(
              id: "module_3_2",
              name: "Behavioral Interview Preparation",
              order: 2,
              learningItems: [
                LearningItem(
                  id: "item_3_2_1",
                  title: "STAR Method",
                  description: "Structure behavioral interview responses.",
                  order: 1,
                ),
                LearningItem(
                  id: "item_3_2_2",
                  title: "Leadership Stories",
                  description: "Demonstrate leadership accomplishments.",
                  order: 2,
                ),
                LearningItem(
                  id: "item_3_2_3",
                  title: "Failure and Recovery",
                  description: "Discuss setbacks and lessons learned.",
                  order: 3,
                ),
                LearningItem(
                  id: "item_3_2_4",
                  title: "Innovation Examples",
                  description: "Showcase creative marketing initiatives.",
                  order: 4,
                ),
                LearningItem(
                  id: "item_3_2_5",
                  title: "Cross-Functional Collaboration",
                  description: "Highlight partnership success stories.",
                  order: 5,
                ),
              ],
            ),
            Module(
              id: "module_3_3",
              name: "Executive Communication",
              order: 3,
              learningItems: [
                LearningItem(
                  id: "item_3_3_1",
                  title: "Executive Presentation",
                  description: "Deliver concise business presentations.",
                  order: 1,
                ),
                LearningItem(
                  id: "item_3_3_2",
                  title: "Board-Level Communication",
                  description: "Communicate with senior leadership.",
                  order: 2,
                ),
                LearningItem(
                  id: "item_3_3_3",
                  title: "Negotiation Skills",
                  description: "Navigate complex business discussions.",
                  order: 3,
                ),
                LearningItem(
                  id: "item_3_3_4",
                  title: "Persuasive Communication",
                  description: "Influence stakeholders with data and insights.",
                  order: 4,
                ),
                LearningItem(
                  id: "item_3_3_5",
                  title: "Personal Branding",
                  description:
                      "Present yourself as a strategic marketing leader.",
                  order: 5,
                ),
              ],
            ),
            Module(
              id: "module_3_4",
              name: "Mock Interview Practice",
              order: 4,
              learningItems: [
                LearningItem(
                  id: "item_3_4_1",
                  title: "Common Interview Questions",
                  description:
                      "Prepare answers for frequently asked questions.",
                  order: 1,
                ),
                LearningItem(
                  id: "item_3_4_2",
                  title: "Case Interview Practice",
                  description: "Solve marketing business cases.",
                  order: 2,
                ),
                LearningItem(
                  id: "item_3_4_3",
                  title: "Executive Panel Interviews",
                  description: "Prepare for multi-interviewer sessions.",
                  order: 3,
                ),
                LearningItem(
                  id: "item_3_4_4",
                  title: "Salary Negotiation",
                  description: "Discuss compensation professionally.",
                  order: 4,
                ),
                LearningItem(
                  id: "item_3_4_5",
                  title: "Final Interview Preparation",
                  description:
                      "Review key topics and build interview confidence.",
                  order: 5,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
