# Art Profiles Smart Contract

## Overview
The Art Profiles Smart Contract is part of the Art Portfolio Hub project, allowing artists to register, update, and retrieve their profiles. Profiles include details such as name, art style, medium used, exhibitions, and portfolio links.

## Contract Functions

### 1. Register Profile
```clarity
(define-public (register-profile
    (art_style (string-ascii 100))
    (medium_used (string-ascii 100))
    (exhibitions (list 10 (string-ascii 100)))
    (portfolio_links (list 10 (string-ascii 200)))
))
```

**Purpose:** Allows an artist to create their profile.

**Parameters:**
- `art_style`: The artist's style (e.g., abstract, realism).
- `medium_used`: Materials used (e.g., oil, digital).
- `exhibitions`: List of exhibitions attended.
- `portfolio_links`: Links to the artist's work.

**Returns:**
- `ok` with a success message if the profile is created.
- `err` if the profile already exists or inputs are invalid.

### 2. Update Profile
```clarity
(define-public (update-profile
    (art_style (string-ascii 100))
    (medium_used (string-ascii 100))
    (exhibitions (list 10 (string-ascii 100)))
    (portfolio_links (list 10 (string-ascii 200)))
))
```

**Purpose:** Allows an artist to update their existing profile.

**Returns:**
- `ok` with a success message if updated.
- `err` if the profile does not exist or inputs are invalid.

## Read-Only Functions

### 1. Get Profile
```clarity
(define-read-only (get-profile (user principal)))
```

**Purpose:** Fetch the full profile of the specified artist.

**Returns:**
- `ok` with profile data if found.
- `err` if the profile does not exist.

### 2. Get Art Style
```clarity
(define-read-only (get-art-style (user principal)))
```

**Purpose:** Retrieve the art style of a specific artist.

**Returns:**
- `ok` with the art style.
- `err` if the profile does not exist.

### 3. Get Exhibitions
```clarity
(define-read-only (get-exhibitions (user principal)))
```

**Purpose:** Fetch the exhibitions attended by an artist.

**Returns:**
- `ok` with the list of exhibitions.
- `err` if the profile does not exist.

### 4. Get Portfolio Links
```clarity
(define-read-only (get-portfolio-links (user principal)))
```

**Purpose:** Retrieve portfolio links of an artist.

**Returns:**
- `ok` with the list of links.
- `err` if the profile does not exist.

## Installation and Usage

1. Clone the Art Portfolio Hub repository:
```bash
git clone https://github.com/Mercieeeee/art_portfolio_hub.git
cd art_portfolio_hub
```

2. Deploy the art_profiles smart contract:
```bash
clarity-cli deploy art_profiles ./contracts/art_profiles.clar
```

3. Interact with the contract using `clarity-cli` or integrate it into a frontend application.

## Testing

Unit tests can be implemented using Clarity test frameworks. Example:
```bash
clarity-cli test ./tests/art_profiles_test.clar
```

## License

This project is licensed under the MIT License. See the LICENSE file for details.