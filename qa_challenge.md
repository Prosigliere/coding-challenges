---

# QA Automation Challenge

This challenge evaluates your ability to build structured, reliable frontend UI tests that validate both static and dynamic elements of a production web app.

**Target application:** [OnTourTix](https://ontourtix.com)

---

## Objective

Automate key validations on the OnTourTix homepage to demonstrate:

* How well you structure tests using `describe` / `it` blocks
* How you handle element identification and interaction

---

## What Your Test Should Cover

### Scenario 1: Homepage UI Validation

Your script should verify that key static elements exist on the homepage, including:

* The header/navigation bar
* The search field
* The event listing/grid
* The footer

**Goal:** Demonstrate use of Cypress (or Selenium) for presence/visibility checks and proper test block structure.

---

### Scenario 2: Search and Navigate to Event

Build a test that:

1. Identifies a visible event title from the homepage
2. Inputs that event name into the search field
3. Executes the search and selects the correct event from the results
4. Navigates to that event's detail page

Then assert:

* The event name appears in the detail view
* Date and location are visible
* At least one ticketing option is available

**Goal:** Validate dynamic UI behavior and element-based navigation.

---

## Tools & Frameworks

You may use:

* **Cypress** / * **Playwright** (recommended for JavaScript-based automation)
* **Selenium WebDriver** (if you prefer another language)

Optional but encouraged:

* Use **Gherkin** syntax for test case documentation
* Use **Mocha + Chai**, **Jest**, or any preferred assertion libraries

---

## Submission Instructions

* Please send an email to the hiring manager including a Github link to the code you created at your earliest convenience.
* If GitHub is not an option, email a `.zip` of your project to the hiring manager.
* Include a `README.md` or clear instructions to install dependencies and run the tests.

---

## Requirements

* Internet access
* [GitHub account](https://github.com/join)
* A local development setup with your preferred IDE and Node/npm or language toolchain
* ⚠️ Do **not** use test recorder-generated code

---

## Questions?

Reach out to the hiring manager

---