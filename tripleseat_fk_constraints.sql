-- Foreign Key Constraints for prod_enhanced.tripleseat
-- Run with DATA_ENGINEER role or equivalent privileges
-- Note: Snowflake FKs are informational only (not enforced)

USE ROLE DATA_ENGINEER;
USE SCHEMA prod_enhanced.tripleseat;

-- ===========================================
-- CONTACTS → ACCOUNTS
-- ===========================================
ALTER TABLE contacts 
ADD CONSTRAINT fk_contacts_account 
FOREIGN KEY (account_id) REFERENCES accounts(account_id);

-- ===========================================
-- LEADS → LOCATIONS, CONTACTS
-- ===========================================
ALTER TABLE leads 
ADD CONSTRAINT fk_leads_location 
FOREIGN KEY (location_id) REFERENCES locations(location_id);

ALTER TABLE leads 
ADD CONSTRAINT fk_leads_contact 
FOREIGN KEY (contact_id) REFERENCES contacts(contact_id);

-- ===========================================
-- EVENTS → LOCATIONS, CONTACTS, ACCOUNTS, LEADS
-- ===========================================
ALTER TABLE events 
ADD CONSTRAINT fk_events_location 
FOREIGN KEY (location_id) REFERENCES locations(location_id);

ALTER TABLE events 
ADD CONSTRAINT fk_events_contact 
FOREIGN KEY (contact_id) REFERENCES contacts(contact_id);

ALTER TABLE events 
ADD CONSTRAINT fk_events_account 
FOREIGN KEY (account_id) REFERENCES accounts(account_id);

ALTER TABLE events 
ADD CONSTRAINT fk_events_lead 
FOREIGN KEY (lead_id) REFERENCES leads(lead_id);

-- ===========================================
-- EVENT DETAIL TABLES → EVENTS
-- ===========================================
ALTER TABLE events_bay_resources 
ADD CONSTRAINT fk_bay_resources_event 
FOREIGN KEY (event_id) REFERENCES events(event_id);

ALTER TABLE events_category_totals 
ADD CONSTRAINT fk_category_totals_event 
FOREIGN KEY (event_id) REFERENCES events(event_id);

ALTER TABLE events_net_revenue 
ADD CONSTRAINT fk_net_revenue_event 
FOREIGN KEY (event_id) REFERENCES events(event_id);

ALTER TABLE events_status_changes 
ADD CONSTRAINT fk_status_changes_event 
FOREIGN KEY (event_id) REFERENCES events(event_id);

-- ===========================================
-- Verify constraints were added
-- ===========================================
SHOW IMPORTED KEYS IN SCHEMA prod_enhanced.tripleseat;
