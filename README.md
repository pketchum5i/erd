# Five Iron Golf — Data Warehouse Schema Docs

DBML schema definitions for ERD visualization of the Snowflake data warehouse.
Render at [dbdiagram.io](https://dbdiagram.io).

## Files

### prod_enhanced_mindbody.dbml
**Database:** `PROD_ENHANCED` | **Schema:** `MINDBODY`

Raw MindBody source data. Core tables for clients, visits, reservations, sales, payments, contracts, and scheduling.

- 71 base tables
- 30,894,867 rows / 1,250.26 MB (as of 2026-03-02)
- ~38,608 rows/day avg growth (7-day)

---

### tripleseat_erd.dbml
**Database:** `PROD_ENHANCED` | **Schema:** `TRIPLESEAT`

Raw Tripleseat event management data. Leads, events, contacts, accounts, revenue ledger.

- 2,049,476 rows / 38.78 MB (as of 2026-03-02)
- ~200 rows/day avg growth (7-day, EVENTS + LEADS + CONTACTS + ACCOUNTS)

---

### prod_reports.dbml
**Database:** `PROD_REPORTS`

Business-ready reporting views across multiple schemas.

| Schema | Table | Description |
|--------|-------|-------------|
| `business` | `locations` | Master location reference — joins MindBody, Tripleseat, Square, Paylocity IDs |
| `membership` | `all_contracts` | All membership contracts with billing, status, and termination detail |
| `lessons` | `total_lesson_hours` | One row per lesson visit — coach, client, timing, pricing |
| `utilization` | `utilization_by_hours_gap_filled` | Hourly utilization by location with gap-filling |
| `events` | `events_and_leads` | Tripleseat leads + events unified, with revenue breakdown and survey scores |
| `events` | `survey_responses` | Post-event surveys, one row per event |

---

### prod_integration.dbml
**Database:** `PROD_INTEGRATION`

Cross-source integration layer.

| Schema | Table | Description |
|--------|-------|-------------|
| `sales` | `line_item_sales` | One row per sale line item across MindBody and Square. Primary revenue reporting table — use `NET_REVENUE`. |

---

## Known Issues

### WSL/Windows File Corruption

When editing `.dbml` files from WSL on a Windows filesystem (`/mnt/c/...`), null bytes (`\x00`) can appear at the end of files due to filesystem sync issues between WSL and Windows. This corrupts the file and causes parsing errors.

**To check for corruption:**
```bash
xxd your_file.dbml | tail -5  # Look for 00 00 00 sequences
```

**To fix:**
```bash
tr -d '\0' < your_file.dbml > temp && mv temp your_file.dbml
```

**Prevention:**
- Always ensure files end with a newline
- Run `git diff` before committing to spot binary artifacts
- Consider editing files from native Windows or moving repo to WSL filesystem (`~/`)
