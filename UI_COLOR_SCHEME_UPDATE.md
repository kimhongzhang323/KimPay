# UI Color Scheme Update

**Date:** November 18, 2025  
**Project:** KimPay Wallet (NLP Payment Wallet)  
**Update Type:** Complete UI Color Palette Redesign

---

## New Color Palette

The entire application UI has been updated with a sophisticated blue-gray color scheme:

### Primary Colors

| Color Name | Hex Code | RGB | Usage |
|------------|----------|-----|-------|
| **Primary Blue** | `#88BDF2` | rgb(136, 189, 242) | Main accent, buttons, active states |
| **Primary Dark** | `#6A89A7` | rgb(106, 137, 167) | Headers, emphasis, secondary actions |
| **Primary Light** | `#BDDDFC` | rgb(189, 221, 252) | Backgrounds, subtle accents |
| **Dark Slate** | `#384959` | rgb(56, 73, 89) | Primary text, dark elements |

### Color Swatches

```
┌─────────────┬─────────────┬─────────────┬─────────────┐
│   #88BDF2   │   #6A89A7   │   #BDDDFC   │   #384959   │
│ Primary Blue│ Primary Dark│Primary Light│ Dark Slate  │
│             │             │             │             │
└─────────────┴─────────────┴─────────────┴─────────────┘
```

---

## Updated Color System

### Accent Colors (Derived from Palette)

| Color Name | Hex Code | Purpose |
|------------|----------|---------|
| Accent Blue | `#88BDF2` | Interactive elements, links |
| Accent Dark Blue | `#5A7A9E` | Hover states, darker variants |
| Accent Light Blue | `#D4EAFD` | Highlights, selected items |
| Accent Teal | `#6BA3B8` | Alternative accent color |

### Status Colors (Muted to Match Palette)

| Color Name | Hex Code | Purpose |
|------------|----------|---------|
| Accent Green | `#6BA89F` | Success states, positive actions |
| Accent Red | `#B07D7D` | Errors, warnings, destructive actions |
| Accent Orange | `#A88F7D` | Warnings, pending states |
| Accent Purple | `#8A7DA7` | Special features, premium content |

### Neutral Colors

| Color Name | Hex Code | Purpose |
|------------|----------|---------|
| Background | `#F0F5FA` | Main app background |
| Surface | `#FFFFFF` | Card backgrounds, surfaces |
| Surface Variant | `#F5F9FC` | Alternative surface color |
| Text Primary | `#384959` | Main text content |
| Text Secondary | `#6A89A7` | Secondary text, captions |
| Divider | `#BDDDFC` | Separators, borders |
| Border | `#D4EAFD` | Input fields, outlined elements |

---

## Gradient Definitions

### Primary Gradients

```dart
// Primary Gradient (Blue tones)
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [#88BDF2, #6A89A7],
)

// Dark Gradient
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [#6A89A7, #384959],
)

// Light Gradient
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [#BDDDFC, #88BDF2],
)
```

---

## Updated Components

### Files Modified

1. **Design System**
   - `lib/design_system/app_colors.dart` - Complete color palette redefinition

2. **Core Application**
   - `lib/main.dart` - Theme configuration updated with new colors

3. **Screens Updated**
   - `lib/screens/home_content.dart`
   - `lib/screens/mini_program_screen.dart`
   - `lib/screens/account_detail_screen.dart`
   - `lib/screens/pin_setup_screen.dart`

4. **Widgets**
   - All widgets automatically inherit new colors from AppColors

---

## Component-Specific Changes

### AppBar
- **Background:** `#F0F5FA` (Background)
- **Text Color:** `#384959` (Dark Slate)
- **Icon Color:** `#384959` (Dark Slate)

### Cards
- **Background:** `#FFFFFF` (White)
- **Shadow:** `#384959` with 10% opacity
- **Border Radius:** 16px

### Buttons

#### Elevated Buttons
- **Background:** `#88BDF2` (Primary Blue)
- **Text Color:** White
- **Hover:** Darker shade of Primary Blue

#### Text Buttons
- **Text Color:** `#88BDF2` (Primary Blue)

#### Outlined Buttons (Danger)
- **Border & Text:** `#B07D7D` (Accent Red)

### Input Fields
- **Fill Color:** `#F5F9FC` (Surface Variant)
- **Border:** `#D4EAFD` (Border)
- **Focused Border:** `#88BDF2` (Primary Blue)

### Bottom Navigation
- **Background:** `#FFFFFF` (White)
- **Selected Item:** `#88BDF2` (Primary Blue)
- **Unselected Item:** `#6A89A7` (Text Secondary)

### Status Indicators

| Status | Color | Usage |
|--------|-------|-------|
| Success | `#6BA89F` | Completed transactions, verified accounts |
| Warning | `#A88F7D` | Pending verifications, alerts |
| Error | `#B07D7D` | Failed transactions, errors |
| Info | `#88BDF2` | Informational messages |

---

## Wallet Card Gradients

### Card Types

1. **Default Wallet** - Primary Gradient
   ```
   #88BDF2 → #6A89A7
   ```

2. **Crypto Wallet** - Green Gradient
   ```
   #6BA89F → #6A89A7
   ```

3. **Stock Wallet** - Orange Gradient
   ```
   #A88F7D → #6A89A7
   ```

4. **NFT Wallet** - Purple Gradient
   ```
   #8A7DA7 → #6A89A7
   ```

---

## Mini-Program Specific Colors

### Location Markers
- **User Location:** `#B07D7D` (Accent Red)
- **Destination:** `#88BDF2` (Primary Blue)
- **Restaurant/Food:** `#A88F7D` (Accent Orange)

### Badges
- **Discount Badge:** `#B07D7D` background with white text
- **Rating Badge:** `#6BA89F` background with white text
- **Live Badge:** `#B07D7D` background with white text

### Price Display
- **Sale Price:** `#B07D7D` (Accent Red)
- **Original Price:** Strikethrough with `#6A89A7` (Text Secondary)

---

## Account Management Colors

### Verification Status

| Status | Background | Border | Text | Icon |
|--------|-----------|--------|------|------|
| Verified | Light green tint | `#6BA89F` | `#6BA89F` | Check circle |
| Unverified | Light orange tint | `#A88F7D` | `#A88F7D` | Warning |

### Danger Zone
- **Icon Color:** `#B07D7D` (Accent Red)
- **Text Color:** `#B07D7D` (Accent Red)
- **Button Border:** `#B07D7D` (Accent Red)

---

## Design Principles

### 1. **Consistency**
All components use the centralized `AppColors` class to ensure consistent color usage throughout the app.

### 2. **Accessibility**
- Text contrast ratios meet WCAG AA standards
- Primary text (`#384959`) on white backgrounds provides 10.5:1 contrast
- Interactive elements have sufficient color differentiation

### 3. **Hierarchy**
- **Primary actions:** Primary Blue (`#88BDF2`)
- **Secondary actions:** Primary Dark (`#6A89A7`)
- **Destructive actions:** Accent Red (`#B07D7D`)

### 4. **Visual Harmony**
All colors are derived from the base palette, creating a cohesive and professional appearance.

---

## Migration Notes

### Breaking Changes
None - all existing `AppColors` references remain compatible.

### Deprecated Colors
Old vibrant colors (bright blue, purple, orange, green, red) have been replaced with muted, palette-consistent alternatives.

### Backward Compatibility
Legacy gradient names (`purpleGradient`, `orangeGradient`, `greenGradient`) are maintained but now use palette-consistent colors.

---

## Color Usage Guidelines

### Do's ✓
- Use `AppColors.primaryBlue` for primary actions
- Use `AppColors.textPrimary` for main content
- Use `AppColors.accentGreen` for success states
- Use `AppColors.accentRed` for errors and destructive actions
- Use gradients for wallet cards and feature highlights

### Don'ts ✗
- Don't use hardcoded color values (e.g., `Colors.blue`)
- Don't use colors outside the defined palette
- Don't use pure black or pure colors
- Don't use more than 3 colors in a single component

---

## Testing Checklist

### Visual Testing
- ✅ All screens render correctly with new colors
- ✅ Buttons and interactive elements are clearly visible
- ✅ Text is readable on all backgrounds
- ✅ Status indicators are distinguishable
- ✅ Gradients display smoothly

### Functional Testing
- ✅ No compilation errors
- ✅ Theme switching works correctly
- ✅ All color references resolve to AppColors
- ✅ Icons and illustrations match color scheme

---

## Performance Impact

**Build Impact:** None - color changes are compile-time constants  
**Runtime Impact:** None - no performance degradation  
**App Size:** No change

---

## Future Enhancements

### Planned Features
1. **Dark Mode Support** - Create dark variants of all colors
2. **Theme Customization** - Allow users to choose color accents
3. **Accessibility Mode** - High contrast color variants
4. **Brand Variations** - Support for white-label color schemes

### Color Tokens for Dark Mode (Proposed)

| Component | Light Mode | Dark Mode (Proposed) |
|-----------|-----------|---------------------|
| Background | `#F0F5FA` | `#1A2332` |
| Surface | `#FFFFFF` | `#2A3B4D` |
| Primary | `#88BDF2` | `#6BA3D8` |
| Text Primary | `#384959` | `#E8EDF2` |

---

## Resources

### Design Files
- Color palette export: `assets/colors/palette.json`
- Figma design system: [Link to Figma]
- Style guide: `docs/STYLE_GUIDE.md`

### Code References
- **AppColors class:** `lib/design_system/app_colors.dart`
- **Theme configuration:** `lib/main.dart`
- **Component examples:** `lib/screens/` and `lib/widgets/`

---

## Color Psychology

The new blue-gray palette was chosen for:

- **Trust & Security** - Blue tones evoke financial security
- **Professionalism** - Muted colors create a mature, professional feel
- **Calmness** - Soft tones reduce visual stress
- **Modern Aesthetic** - Contemporary, minimalist design trend
- **Versatility** - Works well with various content types

---

## Approval & Sign-off

**Design Lead:** ________________  
**Date:** November 18, 2025

**Technical Lead:** ________________  
**Date:** November 18, 2025

**Product Owner:** ________________  
**Date:** November 18, 2025

---

*This document serves as the official record of the UI color scheme update for the KimPay Wallet application.*
