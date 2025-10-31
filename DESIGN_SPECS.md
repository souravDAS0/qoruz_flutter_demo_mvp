# Qoruz Flutter MVP - UI/UX Design Specifications

## Executive Summary
This MVP focuses on core influencer marketing platform features: authentication, influencer discovery, profile viewing, and basic campaign management. The design follows Qoruz's modern, vibrant aesthetic with emphasis on usability and mobile-first approach.

---

## Visual Design System

### Color Palette
```
Primary Colors:
- Primary Orange: #FF6435 (CTAs, highlights)
- Dark Purple: #3E00A9 (headers, emphasis)
- White: #FFFFFF (backgrounds)

Accent Colors:
- Teal: #2ACC83 (success, verified badges)
- Blue: #00B2EA (links, info)
- Purple: #8D4AFF (premium features)

Text Colors:
- Primary: #000000
- Secondary: #555555
- Tertiary: #999999

Backgrounds:
- Main BG: #FFFFFF
- Card BG: #FAFAFA
- Gradient: Linear from #3E00A9 to #CB36FF
```

### Typography
```
Font Family: System Default (San Francisco on iOS, Roboto on Android)

Sizes:
- H1: 32px (bold) - Page titles
- H2: 24px (semi-bold) - Section headers
- H3: 20px (semi-bold) - Card titles
- Body: 16px (regular) - Main content
- Small: 14px (regular) - Metadata
- Caption: 12px (regular) - Labels

Weights: 400 (regular), 600 (semi-bold), 700 (bold)
```

### Spacing System
```
4px, 8px, 12px, 16px, 24px, 32px, 48px, 64px
Default padding: 16px
Card spacing: 12px
Section spacing: 24px
```

### Component Patterns
**Buttons:**
- Primary: Filled #FF6435, white text, 60px border radius
- Secondary: Outlined #FF6435, orange text
- Text: No border, orange text
- Height: 48px, Padding: 16px 24px

**Cards:**
- Border radius: 16px
- Shadow: 0px 2px 8px rgba(0,0,0,0.1)
- Padding: 16px
- Background: White

**Input Fields:**
- Height: 56px
- Border: 1px solid #E0E0E0
- Border radius: 12px
- Focus: Border #FF6435

---

## MVP Feature Scope

### Must-Have (Phase 1)
1. Onboarding & Authentication
2. Influencer Discovery/Search
3. Influencer Profile View
4. Basic Campaign Creation
5. User Profile (Basic)

### Nice-to-Have (Future)
- Advanced filters
- Real-time messaging
- Payment integration
- Analytics dashboard
- Multi-platform integration

---

## Screen-by-Screen Breakdown

### 1. Splash Screen
**Purpose:** App launch, brand introduction
**Components:**
- Qoruz logo (center)
- Gradient background (#3E00A9 to #CB36FF)
- Loading indicator (optional)

**Duration:** 2 seconds → Navigate to Onboarding/Home

---

### 2. Onboarding Flow (3 screens)
**Purpose:** Introduce value proposition

**Screen 1 - Discover:**
- Illustration (influencer discovery)
- Headline: "Find Perfect Influencers"
- Subtitle: "Browse thousands of verified creators"
- Skip button (top-right)
- Next button (bottom)

**Screen 2 - Connect:**
- Illustration (handshake/connection)
- Headline: "Connect & Collaborate"
- Subtitle: "Direct communication with creators"
- Skip button (top-right)
- Next button (bottom)

**Screen 3 - Grow:**
- Illustration (growth chart)
- Headline: "Track Campaign Success"
- Subtitle: "Real-time analytics and insights"
- Get Started button (primary)

---

### 3. Role Selection Screen
**Purpose:** Choose user type
**Components:**
- Title: "I am a..." (H1, center)
- Two large cards (vertical stack):

  **Brand Card:**
  - Icon (briefcase)
  - Title: "Brand/Agency"
  - Description: "Find influencers for campaigns"
  - Tap to select

  **Creator Card:**
  - Icon (star)
  - Title: "Influencer/Creator"
  - Description: "Discover brand opportunities"
  - Tap to select

- Continue button (bottom, disabled until selection)

---

### 4. Sign Up Screen
**Purpose:** Account creation
**Components:**
- Title: "Create Account" (H1)
- Subtitle: "Join Qoruz as [Role]"
- Form fields:
  - Full Name
  - Email
  - Password (with show/hide toggle)
  - Confirm Password
- Terms checkbox: "I agree to Terms & Privacy Policy"
- Sign Up button (primary, full width)
- Divider: "Or sign up with"
- Social buttons: Google, Apple (icons only)
- Footer: "Already have an account? Login"

**Validation:**
- Email format check
- Password min 8 characters
- Passwords match

---

### 5. Login Screen
**Purpose:** Existing user access
**Components:**
- Title: "Welcome Back" (H1)
- Form fields:
  - Email
  - Password (with show/hide toggle)
- Forgot Password? (link, right-aligned)
- Login button (primary, full width)
- Divider: "Or login with"
- Social buttons: Google, Apple
- Footer: "Don't have an account? Sign Up"

---

### 6. Home/Discovery Screen
**Purpose:** Main influencer search and discovery
**Layout:**

**App Bar:**
- Logo (left)
- Search icon (right)
- Profile avatar (right)

**Search Section:**
- Large search bar with icon
- Placeholder: "Search influencers..."
- Filter button (right side)

**Quick Filters (Horizontal scroll):**
- Chips: "All", "Instagram", "YouTube", "TikTok", "Fashion", "Tech", "Beauty"
- Active state: Filled orange

**Influencer Grid (2 columns):**
Each card contains:
- Profile image (circular, 80px)
- Name (H3)
- Category badge (e.g., "Fashion")
- Platform icons (Instagram, YouTube)
- Followers count (with icon)
- Engagement rate (with icon)
- Action button: "View Profile"

**Bottom Navigation:**
- Home (active)
- Search
- Campaigns
- Profile

---

### 7. Search Filter Screen
**Purpose:** Advanced filtering
**Components:**
- App Bar: "Filters" with Close button
- Sections (scrollable):

  **Platform:**
  - Multi-select chips: Instagram, YouTube, TikTok, Twitter

  **Category:**
  - Dropdown: Fashion, Tech, Beauty, Lifestyle, Food, etc.

  **Followers Range:**
  - Dual slider: Min - Max
  - Labels: 1K, 10K, 100K, 1M, 10M+

  **Engagement Rate:**
  - Dual slider: 0% - 20%+

  **Location:**
  - Search input with autocomplete

  **Gender:**
  - Chips: Male, Female, All

- Footer:
  - Clear All (text button)
  - Apply Filters (primary button)

---

### 8. Influencer Profile Screen
**Purpose:** Detailed influencer information
**Layout:**

**Header (with gradient background):**
- Back button (top-left)
- Share icon (top-right)
- Profile image (120px, center)
- Name (H1, white text)
- Category (white text)
- Verified badge (if applicable)

**Stats Bar (white card overlay):**
- 3 columns:
  - Followers: 125K
  - Engagement: 5.2%
  - Avg Views: 15K

**Platform Tabs:**
- Chips: Instagram, YouTube, TikTok
- Shows platform-specific content

**About Section:**
- Bio text
- Location
- Languages
- Joined date

**Portfolio Section:**
- Title: "Recent Work" (H2)
- Grid of content thumbnails (3 columns)
- Tap to expand

**Brands Worked With:**
- Horizontal scroll of brand logos

**Action Buttons (fixed bottom):**
- Message (secondary)
- Start Campaign (primary)

---

### 9. Campaign Creation Screen
**Purpose:** Create new campaign
**Layout:**

**App Bar:**
- Back button
- Title: "Create Campaign"
- Save Draft (text button)

**Form (scrollable):**
1. Campaign Name
   - Text input

2. Campaign Type
   - Dropdown: Product Review, Sponsored Post, Brand Ambassador, etc.

3. Description
   - Multi-line text area

4. Budget
   - Currency input with picker

5. Duration
   - Date range picker (Start - End)

6. Target Platform
   - Multi-select: Instagram, YouTube, TikTok

7. Content Requirements
   - Multi-line text area

8. Select Influencers (optional)
   - Add button → Goes to search
   - Shows selected influencers as chips

**Footer:**
- Cancel (text button)
- Create Campaign (primary button)

---

### 10. Campaigns List Screen
**Purpose:** View all campaigns
**Layout:**

**App Bar:**
- Title: "My Campaigns"
- Add button (+, top-right)

**Filter Tabs:**
- All, Active, Draft, Completed

**Campaign Cards (vertical list):**
Each card:
- Campaign name (H3)
- Status badge (Active/Draft/Completed)
- Platform icons
- Duration dates
- Influencer count
- Budget
- Progress indicator (if active)
- Tap to view details

**Empty State:**
- Illustration
- "No campaigns yet"
- "Create your first campaign" button

---

### 11. User Profile Screen
**Purpose:** User account management
**Layout:**

**Header:**
- Cover image (gradient background)
- Profile image (120px, center)
- Name (H2)
- Role badge (Brand/Creator)
- Edit button (top-right)

**Stats Section (if Brand):**
- Campaigns Created
- Active Collaborations
- Total Spent

**Menu Items:**
- Account Settings
- Payment Methods
- Notifications
- Help & Support
- Terms & Privacy
- Logout (red text)

---

## Navigation Flow

```
Splash → Onboarding (first launch) → Role Selection → Sign Up/Login
                    ↓
               Home Screen
                    ↓
         ┌──────────┼──────────┐
         ↓          ↓          ↓
    Discovery   Campaigns   Profile
         ↓
  Influencer Profile
         ↓
  Campaign Creation
```

**Bottom Navigation Persistence:**
- Home, Search, Campaigns, Profile available on all main screens

---

## Component Library Needed

### Reusable Widgets:
1. **PrimaryButton** - Orange filled button
2. **SecondaryButton** - Orange outlined button
3. **InfluencerCard** - Grid card with influencer info
4. **CampaignCard** - List card with campaign details
5. **CustomTextField** - Styled input field
6. **PlatformChip** - Social platform badge
7. **StatCard** - Metric display widget
8. **ProfileHeader** - Gradient header with image
9. **EmptyState** - Empty list placeholder
10. **LoadingIndicator** - Custom loading spinner

---

## Mobile-First Considerations

### Responsive Breakpoints:
- Mobile: < 600px (primary focus)
- Tablet: 600px - 1024px (stretch layouts)
- Desktop: > 1024px (future consideration)

### Touch Targets:
- Minimum: 48px x 48px
- Recommended: 56px height for inputs/buttons

### Gestures:
- Pull-to-refresh on lists
- Swipe back navigation (iOS)
- Long-press for context menus

### Performance:
- Lazy loading for lists
- Image caching
- Pagination (20 items per page)

---

## Assets & Icons Needed

### Illustrations:
- Onboarding screens (3)
- Empty states (campaigns, search)

### Icons (Material/Cupertino):
- Social platforms (Instagram, YouTube, TikTok, Twitter)
- Navigation (home, search, campaigns, profile)
- Actions (filter, share, message, add)
- Stats (followers, engagement, views)

### Brand:
- Qoruz logo (SVG/PNG)
- App icon (1024x1024)

---

## Implementation Priority

### Phase 1 (Week 1):
1. Setup project structure
2. Design system (colors, typography, widgets)
3. Authentication flow (UI only, mock data)
4. Bottom navigation

### Phase 2 (Week 2):
5. Home/Discovery screen
6. Influencer profile screen
7. Mock data models

### Phase 3 (Week 3):
8. Campaign creation
9. Campaigns list
10. User profile
11. Search & filters

### Phase 4 (Polish):
12. Animations & transitions
13. Error handling
14. Empty states
15. Loading states

---

## Notes for Developer

- Use Provider or Riverpod for state management
- Implement go_router for navigation
- Use dio for future API integration
- Create constants file for colors/text styles
- Implement responsive spacing using MediaQuery
- Add form validation throughout
- Consider using flutter_svg for icons
- Implement secure storage for auth tokens (future)

---

**Design Version:** 1.0
**Last Updated:** 2025-11-01
**Status:** Ready for Development
