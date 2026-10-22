# Nuvio covers

Cover art for Nuvio collections built from @yyppee's Trakt lists. Each cover is generated
from the list's own posters.

- `*-landscape.jpg`: 1280×720, for folders with the **Landscape** tile shape
- `*-poster.jpg`: 600×900, for folders with the **Portrait** tile shape
- `collection-*-backdrop.jpg`: 1920×1080, for each collection's backdrop

Image base URL: `https://raw.githubusercontent.com/ype/nuvio-covers/main/`

## Setup sheet (Nuvio website → Collections)

Use the `trakt.tv/users/...` link format: links to `app.trakt.tv` leave the folder empty.

### Collection 1: **Film School** (Tabbed Grid, Show All Tab off)
Backdrop: `collection-film-school-backdrop.jpg`

| Folder | Trakt list URL | Cover |
|---|---|---|
| Criterion I | https://trakt.tv/users/yyppee/lists/the-criterion-collection-spines-1-678 | `criterion-1-landscape.jpg` |
| Criterion II | https://trakt.tv/users/yyppee/lists/the-criterion-collection-spines-680-1344 | `criterion-2-landscape.jpg` |
| Eclipse | https://trakt.tv/users/yyppee/lists/criterion-eclipse-series | `criterion-eclipse-landscape.jpg` |
| Box Sets | https://trakt.tv/users/yyppee/lists/criterion-box-sets | `criterion-box-sets-landscape.jpg` |
| BFI Critics | https://trakt.tv/users/yyppee/lists/bfi-critics-greatest-films | `bfi-critics-landscape.jpg` |
| BFI Directors | https://trakt.tv/users/yyppee/lists/bfi-directors-greatest-films | `bfi-directors-landscape.jpg` |

### Collection 2: **Independents** (Tabbed Grid)
Backdrop: `collection-studios-backdrop.jpg`

| Folder | Trakt list URL | Cover |
|---|---|---|
| A24 | https://trakt.tv/users/yyppee/lists/a24 | `a24-landscape.jpg` |
| NEON | https://trakt.tv/users/yyppee/lists/neon-films | `neon-landscape.jpg` |
| GKIDS & Ghibli | https://trakt.tv/users/yyppee/lists/gkids | `gkids-landscape.jpg` |
| Arrow Video | https://trakt.tv/users/yyppee/lists/arrow-video | `arrow-video-landscape.jpg` |

### Collection 3: **For You** (Rows, Pin to Top)
Backdrop: `collection-for-you-backdrop.jpg`

| Folder | Trakt list URL | Cover |
|---|---|---|
| Picked for You | https://trakt.tv/users/yyppee/lists/picked-for-you | `picked-for-you-landscape.jpg` |
| Reference Showcase | https://trakt.tv/users/yyppee/lists/4k-hdr-atmos-showcase | `4k-showcase-landscape.jpg` |

For each folder, set the source to **Trakt → Trakt List**, Type **Movie**, Sort **Default**
(keeps the list's own order, for example spine order or poll rank), and use the cover URL as
base URL + file name.
