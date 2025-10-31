# Qoruz Flutter MVP

A Flutter MVP application based on [qoruz.com](https://qoruz.com/) - an influencer marketing platform that connects brands with content creators.

## Overview

This MVP includes the core features of an influencer marketing platform:
- User authentication (Brand/Creator roles)
- Influencer discovery and search
- Detailed influencer profiles
- Campaign creation and management
- User profile management

## Features Implemented

### 1. Authentication Flow
- **Splash Screen**: Brand introduction with gradient background
- **Role Selection**: Choose between Brand/Agency or Influencer/Creator
- **Sign Up**: Create account with role-specific registration
- **Login**: Email/password authentication with social login placeholders

### 2. Influencer Discovery (Home Screen)
- **Search**: Real-time search functionality
- **Filters**: Filter by platform (Instagram, YouTube, TikTok, Twitter) and category (Fashion, Tech, Beauty, etc.)
- **Grid View**: 2-column grid displaying influencer cards
- **Influencer Cards**: Show profile image, name, category, platforms, followers, and engagement rate

### 3. Influencer Profile
- **Header**: Gradient background with profile image, name, and verification badge
- **Stats**: Followers, engagement rate, and average views
- **Platforms**: Display all social platforms the influencer is active on
- **About**: Bio, location, languages, and join date
- **Portfolio**: Grid of recent work/content
- **Brand Collaborations**: List of brands worked with
- **Actions**: Message and Start Campaign buttons

### 4. Campaign Management
- **Campaign List**: View all campaigns with filtering by status (All, Active, Draft, Completed)
- **Campaign Cards**: Display name, type, budget, duration, platforms, and influencer count
- **Campaign Creation**: Complete form for creating new campaigns with:
  - Campaign details (name, type, description)
  - Budget input
  - Date range selection
  - Platform targeting
  - Content requirements

### 5. User Profile
- **Profile Header**: Gradient background with user info and role badge
- **Menu Items**: Account settings, payment methods, notifications
- **Support**: Help & support, terms & privacy
- **Logout**: Secure logout with confirmation dialog

## Technical Stack

### Dependencies
- **flutter**: Core framework
- **provider**: State management (^6.1.1)
- **go_router**: Navigation (^14.6.2)
- **dio**: HTTP client for future API integration (^5.4.0)
- **flutter_svg**: SVG support (^2.0.9)
- **shared_preferences**: Local storage (^2.2.2)
- **intl**: Date/number formatting (^0.19.0)

### Project Structure
```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart       # Color palette
│   │   ├── app_text_styles.dart  # Typography
│   │   └── app_spacing.dart      # Spacing/sizing constants
│   └── theme/
│       └── app_theme.dart        # Material theme configuration
├── models/
│   ├── user_model.dart           # User data model
│   ├── influencer_model.dart     # Influencer data model
│   ├── campaign_model.dart       # Campaign data model
│   └── social_platform.dart      # Platform enums & stats
├── providers/
│   ├── auth_provider.dart        # Authentication state
│   ├── influencer_provider.dart  # Influencer data & filtering
│   └── campaign_provider.dart    # Campaign management
├── services/
│   └── mock_data_service.dart    # Mock data for MVP
├── screens/
│   ├── auth/                     # Authentication screens
│   ├── home/                     # Discovery/home screen
│   ├── influencer/               # Influencer profile
│   ├── campaign/                 # Campaign screens
│   └── profile/                  # User profile
├── widgets/
│   └── influencer_card.dart      # Reusable influencer card
├── routes/
│   └── app_router.dart           # Navigation configuration
└── main.dart                     # App entry point
```

## Design System

### Color Palette
- **Primary Orange**: #FF6435 (CTAs, highlights)
- **Dark Purple**: #3E00A9 (headers, emphasis)
- **Teal**: #2ACC83 (success, verified badges)
- **Blue**: #00B2EA (links, info)
- **Purple**: #8D4AFF (premium features)

### Typography
- **H1**: 32px, Bold - Page titles
- **H2**: 24px, Semi-bold - Section headers
- **H3**: 20px, Semi-bold - Card titles
- **Body**: 16px, Regular - Main content
- **Small**: 14px, Regular - Metadata
- **Caption**: 12px, Regular - Labels

### Components
- **Buttons**: 60px border radius (pill-shaped), 48px height
- **Cards**: 16px border radius, subtle shadows
- **Input Fields**: 56px height, 12px border radius
- **Spacing**: 4px, 8px, 12px, 16px, 24px, 32px, 48px, 64px scale

## Mock Data

The app uses mock data for the MVP with:
- 6 sample influencers across different categories
- Mock platform statistics
- Sample campaigns
- Realistic data structures ready for API integration

### Sample Influencers
1. **Sarah Johnson** - Fashion (125K Instagram followers)
2. **Alex Chen** - Tech (450K YouTube subscribers)
3. **Emma Rodriguez** - Beauty (320K Instagram followers)
4. **David Kim** - Fitness (280K Instagram, 420K TikTok)
5. **Lisa Anderson** - Food (195K Instagram, 150K YouTube)
6. **Marcus Thompson** - Travel (380K Instagram, 290K YouTube)

## How to Run

### Prerequisites
- Flutter SDK (^3.9.0)
- Dart SDK
- iOS Simulator / Android Emulator / Physical Device

### Installation

1. **Clone the repository**
   ```bash
   cd /Users/souravdas/personalProjects/qoruz_flutter_sourav
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Testing
Run Flutter tests:
```bash
flutter test
```

Run code analysis:
```bash
flutter analyze
```

## User Flow

1. **First Launch**: Splash screen → Role selection
2. **Sign Up**: Choose role → Enter details → Home screen
3. **Login**: Email/password → Home screen
4. **Discovery**: Browse influencers → Apply filters → View profiles
5. **Campaign Creation**: Create campaign → Set parameters → Save
6. **Profile Management**: View profile → Access settings → Logout

## Features for Future Development

### Phase 2 (Post-MVP)
- Real API integration
- Advanced search filters (followers range, engagement rate, location)
- In-app messaging between brands and creators
- Campaign analytics dashboard
- Payment integration
- Multi-image upload for campaigns
- Push notifications
- Dark mode

### Phase 3 (Advanced)
- Real-time chat
- Video content preview
- Campaign performance tracking
- Contract management
- Invoice generation
- Multi-platform posting
- AI-powered influencer recommendations

## Authentication

Current implementation uses mock authentication:
- **Any email/password** will work for login
- **Sign up** creates a temporary user in memory
- **Session** persists during app runtime
- Ready for Firebase Auth, OAuth, or custom backend integration

## State Management

Uses Provider pattern for:
- **AuthProvider**: User authentication state
- **InfluencerProvider**: Influencer data, search, and filtering
- **CampaignProvider**: Campaign CRUD operations

## Navigation

Uses go_router for declarative routing:
- Deep linking ready
- Named routes
- Query parameters support
- Type-safe navigation

## Responsive Design

- Mobile-first approach
- Adaptive layouts for different screen sizes
- Touch targets minimum 48x48px
- Works on both iOS and Android

## Code Quality

- Clean architecture principles
- Reusable widgets
- Consistent naming conventions
- Commented code for complex logic
- No lint issues
- Type-safe throughout

## Screenshots Guide

### Key Screens to Test
1. Splash → Auto-navigates to role selection
2. Role Selection → Choose Brand or Creator
3. Sign Up → Fill form and create account
4. Home → Browse grid of influencers
5. Search → Type to filter results
6. Filters → Tap chips to filter by platform/category
7. Influencer Profile → Tap any influencer card
8. Campaigns → Bottom nav → View campaign list
9. Create Campaign → Tap + icon
10. Profile → Bottom nav → View user profile

## Performance Considerations

- Lazy loading for lists (prepared for pagination)
- Image caching via NetworkImage
- Efficient state updates
- Minimal rebuilds with Provider
- Ready for API optimization

## Known Limitations (MVP Scope)

1. No backend integration (mock data only)
2. No real authentication persistence
3. Social login buttons are placeholders
4. Image uploads not implemented
5. Real-time features not included
6. No actual payment processing
7. Campaign analytics coming in Phase 2

## Contributing

This is an MVP for demonstration purposes. The codebase is structured to easily:
- Add new screens
- Integrate real APIs
- Extend data models
- Add new features

## Design Documentation

See `DESIGN_SPECS.md` for comprehensive UI/UX specifications including:
- Complete screen-by-screen breakdown
- Component library
- Navigation flows
- Mobile-first considerations
- Implementation priorities

## License

Private project - All rights reserved

## Contact

For questions about this MVP, please contact the development team.

---

**Built with**: Flutter 3.9+ | Provider | go_router
**MVP Version**: 1.0.0
**Last Updated**: 2025-11-01
**Status**: Ready for Demo
