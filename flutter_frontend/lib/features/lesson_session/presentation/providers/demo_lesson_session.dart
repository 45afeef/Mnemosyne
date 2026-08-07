import '../../../assessment/domain/entities/flashcard.dart';
import '../../../assessment/domain/entities/mcq.dart';
import '../../../learning/domain/entities/learning_content.dart';
import '../../domain/entities/lesson_session.dart';
import '../../domain/entities/session_step.dart';
import '../../domain/entities/topic.dart';

final demoLessonSession = LessonSession(
  id: 'session_1',
  title: 'Introduction Session',
  topics: [
    Topic(
      id: 'topic_1',
      title: 'Basics',
      steps: [
        LearningStep(
          id: 'learning_1',
          title: 'Introduction',
          content: LearningContent(
            id: 'content_1',
            title: 'Shoot Travel Video?',
            markdown: '''

# What and How to Shoot a Travel Reel Video: A Complete Guide

![A traveler filming a scenic destination with a smartphone](images/travel-reel-hero.jpg)

## Introduction

![diagram](https://dummyimage.com/800x400/122131/c0c1ff)

A travel reel video is a short, engaging visual story that captures the feeling of a destination in just a few seconds. A great travel reel is not only about showing beautiful places; it is about making viewers feel the journey through creative shots, movement, emotions, and storytelling.

> Whether you are using a smartphone, action camera, or professional camera, the goal is to capture memorable moments that inspire people to explore.

---

# What to Shoot for a Travel Reel Video

## 1. Capture the Journey, Not Just the Destination

![Traveler walking through an airport or road trip scene](images/journey-shot.jpg)

A travel reel becomes more interesting when it shows the complete experience. Include moments before reaching the destination, such as packing bags, boarding transport, road views, checking maps, or walking through new streets.

**Shot ideas:**

* Packing essentials
* Closing a suitcase
* Airport or railway station clips
* Window views during travel
* First steps into a new location

---

## 2. Record Establishing Shots

![Wide landscape view of a travel destination](images/establishing-shot.jpg)

Start your reel with a wide shot that introduces the location. These shots help viewers understand where the story is happening.

Examples:

* Mountains from a distance
* City skyline
* Beach horizon
* Historic buildings
* Forest landscapes

---

## 3. Focus on Local Culture and People

![Local market and cultural experience](images/local-culture.jpg)

Travel is about people and experiences. Capture local traditions, food preparation, street scenes, and everyday activities.

Try filming:

* Local markets
* Traditional clothing
* Street performances
* Conversations
* Unique cultural moments

---

# How to Shoot a Travel Reel Video

## 4. Plan a Simple Story Before Recording

![Traveler planning shots using a notebook](images/story-planning.jpg)

A good reel follows a simple structure:

**Beginning → Experience → Highlight → Ending**

Example:

* Beginning: Arriving at a destination
* Middle: Exploring places and activities
* Highlight: The most beautiful or exciting moment
* Ending: A memorable final shot

Planning prevents random clips from feeling disconnected.

---

## 5. Use Different Camera Angles

![Different camera angles while filming travel scenes](images/camera-angles.jpg)

Avoid recording everything from eye level. Different angles make your reel more dynamic.

Try:

* Low-angle shots for dramatic views
* Top-down shots for food or objects
* Close-ups for details
* Wide shots for landscapes
* Over-the-shoulder shots for a cinematic feel

---

# 10+ Actionable Tips for Shooting Better Travel Reels

## Tip 1: Shoot Vertical Video

Most reels are viewed on mobile devices, so record in a **9:16 vertical format**. This fills the screen and looks natural on platforms like Instagram and YouTube Shorts.

---

## Tip 2: Record Short Clips

Instead of recording one long video, capture multiple clips of 2–5 seconds each. Short clips are easier to edit and create better pacing.

---

## Tip 3: Capture Movement

Movement makes travel videos feel alive.

Examples:

* Walking toward a location
* Moving the camera from left to right
* Following a person
* Turning around to reveal a view
* Driving or traveling shots

---

## Tip 4: Use the "Reveal Shot" Technique

Create curiosity by hiding the main view and revealing it slowly.

Examples:

* Walk past a tree to reveal a waterfall
* Move the camera upward to show mountains
* Open a door to reveal a beautiful room

---

## Tip 5: Record Natural Sounds

![Recording natural travel sounds](images/natural-audio.jpg)

Audio adds emotion to your reel.

Capture:

* Ocean waves
* Birds
* Street sounds
* Local music
* Footsteps
* Conversations

You can mix these sounds with background music during editing.

---

## Tip 6: Shoot During Golden Hour

The first hour after sunrise and the last hour before sunset provide soft, warm lighting.

Benefits:

* Better colors
* Less harsh shadows
* More cinematic atmosphere

---

## Tip 7: Include Yourself in the Video

![Traveler appearing in a scenic location](images/self-inclusion.jpg)

A travel reel feels more personal when viewers see the traveler.

Try:

* Walking away from the camera
* Looking at the scenery
* Enjoying food
* Exploring streets
* Reacting naturally

---

## Tip 8: Capture Small Details

Big landscapes are impressive, but small details create storytelling.

Record:

* Food close-ups
* Local decorations
* Travel tickets
* Maps
* Hands interacting with objects
* Textures and colors

---

## Tip 9: Keep the Camera Stable

Shaky footage can reduce video quality.

Improve stability by:

* Holding the phone with both hands
* Using a tripod or gimbal
* Walking slowly while filming
* Keeping movements smooth

---

## Tip 10: Edit With Rhythm

Match your clips with the music beat. Change scenes when the energy changes.

Editing tips:

* Remove unnecessary clips
* Start with your strongest shot
* Use smooth transitions
* Keep the reel fast-paced
* Add text captions when useful

---

## Tip 11: Always Capture Extra Footage

![Camera capturing extra travel moments](images/extra-footage.jpg)

Record more clips than you think you need. Extra footage gives you more choices while editing.

Useful extra shots:

* Walking sequences
* Landscape movements
* Street views
* Food preparation
* Sunset or night scenes

---

# Suggested Travel Reel Structure

## 30-Second Travel Reel Example

```
0-3 seconds:
Attention-grabbing opening shot

3-10 seconds:
Journey and arrival moments

10-20 seconds:
Main experiences and activities

20-27 seconds:
Best highlights

27-30 seconds:
Final memorable shot
```

---

# Essential Travel Reel Shot Checklist

✅ Destination introduction shot
✅ Travel journey clips
✅ Walking shots
✅ Food experience
✅ Local culture moments
✅ Landscape shots
✅ Personal appearance
✅ Close-up details
✅ Movement shots
✅ Final cinematic ending shot

---

# Final Thoughts

A successful travel reel is not created by expensive equipment alone. It comes from observing your surroundings, planning your story, and capturing moments that communicate emotion.

Focus on telling a small story instead of collecting random clips. When viewers can feel the adventure through your video, your travel reel becomes memorable.

''',
          ),
        ),
        McqStep(
          id: 'mcq_1',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_1',
            question: 'What is Flutter?',
            options: [
              McqOption(id: 'a', text: 'A UI toolkit'),
              McqOption(id: 'b', text: 'A database'),
              McqOption(id: 'c', text: 'An operating system'),
            ],
            correctOptionId: 'a',
            explanation: 'Flutter is a UI toolkit by Google.',
          ),
        ),
        FlashcardStep(
          id: 'flashcard_1',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_1',
            front: 'Flutter',
            back: 'A framework for building cross-platform apps.',
          ),
        ),
        McqStep(
          id: 'mcq_2',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_1',
            question: 'What is Flutter?',
            options: [
              McqOption(id: 'a', text: 'A'),
              McqOption(id: 'b', text: 'B'),
              McqOption(id: 'c', text: 'C'),
            ],
            correctOptionId: 'a',
            explanation: 'Flutter is a UI toolkit by Google.',
          ),
        ),
        FlashcardStep(
          id: 'flashcard_2',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_1',
            front: 'Flutter',
            back: 'A framework for building cross-platform apps.',
          ),
        ),
      ],
    ),
  ],
);
