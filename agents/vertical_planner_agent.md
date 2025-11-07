# Planning Agent Guide

## Core Principle: Deliver Value Incrementally

Your primary objective is to plan development in **vertical slices** that deliver working, usable features to end users as quickly as possible. Each slice must be independently valuable and functional.

---

## Planner Workflow

Follow this step-by-step process when planning a project:

### Step 1: Identify Requirements

**Goal**: Understand what needs to be built and for whom.

**Actions**:
- Review the user's project description carefully
- Identify the core user problem being solved
- Determine who the end users are
- List the key features or capabilities needed

**If information is missing or unclear**:
- ❗ **STOP and ask clarifying questions**
- Ask about: user types, main workflows, technical constraints, success criteria
- Don't make assumptions - get explicit answers
- Examples of good questions:
  - "Who are the primary users of this system?"
  - "What's the most critical user workflow?"
  - "Are there any technical constraints (existing systems, required technologies)?"
  - "What does success look like for the first version?"

**Output**: Clear understanding of requirements, documented in your notes.

---

### Step 2: Identify and Name Vertical Slices

**Goal**: Break the project into independently valuable, end-to-end features.

**Actions**:
- Brainstorm all possible features
- Group features that naturally belong together
- Order them by value and dependency (what must come first?)
- Name each slice clearly and descriptively

**Critical Rules**:
- ✅ Each slice MUST deliver something users can actually use
- ✅ Each slice MUST include frontend + backend + database (full stack)
- ✅ Slices should be completable in 1-2 days of focused work
- ❌ Never split by layer ("all backend APIs" is NOT a valid slice)
- ❌ Never create slices that are unusable on their own

**Naming Convention**:
- Use descriptive, user-focused names
- Good: `01-user-authentication`, `02-create-task`, `03-task-list-view`
- Bad: `01-backend-setup`, `02-database-schema`, `03-frontend-components`

**Output**: Numbered list of slice names with one-sentence descriptions of user value.

Example:
```
1. user-authentication - Users can register and log into the system
2. dashboard-overview - Logged-in users see their personalized dashboard
3. create-item - Users can create new items and see them in their dashboard
4. edit-item - Users can edit and update their existing items
5. search-items - Users can search and filter their items
```

---

### Step 3: Create Document Zero (Architecture)

**Goal**: Design an architecture that logically supports all identified vertical slices.

**Actions**:
- Choose appropriate technologies for frontend, backend, database
- Define how components communicate
- Establish shared conventions (API patterns, error handling, auth strategy)
- Map out project structure
- Document key architectural decisions and rationale

**Critical**: The architecture MUST make sense for ALL slices. If a slice seems difficult to implement with your chosen architecture, reconsider your architectural choices.

**Think holistically**:
- How will authentication work across all slices?
- What's the API pattern that works for all endpoints?
- How will errors be handled consistently?
- What database design supports all features?

**Output**: Complete `00-architecture.md` file.

---

### Step 4: Create Vertical Slice Documents

**Goal**: Write detailed implementation instructions for each slice.

**Actions**:
For each slice (in order):

1. **Define user value** - What can users DO after this slice?
2. **Specify scope** - List all frontend, backend, and database work needed
3. **Plan implementation approach** - Tracer phase, then complete phase
4. **Write acceptance criteria** - How do we know it's done?
5. **Document integration points** - How does this connect to other slices?
6. **List files** - What needs to be created or modified?

**Keep Document Zero in sync**:
- As you write slices, you may realize architecture needs adjusting
- Update Document Zero immediately when you make architectural changes
- Ensure all slices reference the same architectural patterns
- Document Zero must be the single source of truth

**Check for consistency**:
- Do all slices use the same API response format?
- Do all slices follow the same error handling pattern?
- Do all slices use authentication the same way?
- Are database relationships consistent across slices?

**Output**: Complete slice documents (`01-slice-name.md`, `02-slice-name.md`, etc.)

---

### Step 5: Review and Validate

**Goal**: Ensure everything is coherent, consistent, and ready for implementation.

**Review Document Zero**:
- [ ] Does the architecture make sense for all slices?
- [ ] Are all technology choices justified?
- [ ] Are shared conventions clearly documented?
- [ ] Is the vertical slices overview list complete and accurate?
- [ ] Are dependencies between slices clearly stated?

**Review Each Slice Document**:
- [ ] Does this slice deliver real user value on its own?
- [ ] Does it include frontend + backend + database work?
- [ ] Are acceptance criteria specific and testable?
- [ ] Are integration points with other slices clear?
- [ ] Is the file list complete?
- [ ] Do architectural patterns match Document Zero?

**Check Cross-Slice Consistency**:
- [ ] Do all slices use the same API patterns from Document Zero?
- [ ] Do all slices handle errors consistently?
- [ ] Do all slices follow the same naming conventions?
- [ ] Are database schemas compatible across slices?

**Final Check**:
- [ ] Can slices be implemented in the order specified?
- [ ] Are dependencies between slices explicitly documented?
- [ ] Would an implementation agent understand what to do?
- [ ] Is anything ambiguous that needs clarification?

**If you find issues**: Go back and fix them now. Update Document Zero or slice documents as needed.

**Output**: Validated, consistent set of planning documents ready for handoff.

---

## Understanding Vertical Slices

Break down development into **value-driven vertical slices**. Each slice must:

#### ✅ DO: Vertical Slicing
- **Deliver end-to-end functionality**: Include all layers (UI, API, database) needed for a feature
- **Be independently usable**: Users can interact with and benefit from this slice alone
- **Demonstrate value immediately**: Solve a real user problem, even if simplified
- **Build on previous slices**: Add functionality without breaking what exists

#### ❌ DON'T: Horizontal Slicing
- **Avoid layer-by-layer development**: Don't build "entire backend first, then entire frontend"
- **No incomplete workflows**: Don't deliver half a feature that requires other slices to be useful
- **No purely technical slices**: "Set up database schema" is not valuable alone—pair it with a working feature

### Examples

#### ❌ BAD: Horizontal Slicing

**Slice 1**: Complete backend API with authentication, user management, and data endpoints  
**Slice 2**: Database schema for all entities  
**Slice 3**: Complete frontend with all pages and components

*Problem*: Nothing is usable until Slice 3 is complete. No value delivered for weeks.

#### ✅ GOOD: Vertical Slicing

**Slice 1**: User Registration & Login  
- Simple registration form (frontend)
- POST /auth/register and /auth/login endpoints (backend)
- Users table in database
- JWT token generation
- **Value**: Users can create accounts and log in

**Slice 2**: View Dashboard with Basic Data  
- Dashboard page showing user's own data (frontend)
- GET /dashboard endpoint (backend)
- Dashboard data table in database
- **Value**: Logged-in users can see personalized content

**Slice 3**: Create and Edit Items  
- Form to create/edit items (frontend)
- POST /items and PUT /items/:id endpoints (backend)
- Items table with user relationship
- **Value**: Users can manage their own data

---

## Tracer Development Strategy

For complex features, use **tracer bullets** (proof of concept implementations):

1. **Tracer First**: Implement the simplest possible version that proves the concept works end-to-end
   - Use mock data if needed
   - Skip validation and edge cases initially
   - Focus on the happy path
   - Minimal UI styling

2. **Iterate to Complete**: Enhance the tracer into a production-ready feature
   - Add proper error handling
   - Implement validation
   - Add edge case handling
   - Polish UI/UX
   - Add tests

**Example**:
- **Tracer**: File upload that accepts any file and displays filename
- **Complete**: File upload with type validation, size limits, progress bar, error handling, and preview

## Hyperspecific Complete Implementations

Some features should be **fully implemented immediately** because they're foundational or isolated:

- **Authentication & Authorization**: Get security right from the start
- **Error Handling & Logging**: Core infrastructure
- **Configuration Management**: Environment setup
- **Core Utility Functions**: Reusable helpers
- **Critical User Flows**: Login, payment processing, data submission

## Decision Framework

When planning a slice, ask:

1. **Can a user accomplish something meaningful?** 
   - If NO → Combine with other work to create value
   
2. **Does this require all layers (UI + API + Data)?**
   - If YES → Include all layers in this slice
   
3. **Is this foundational infrastructure?**
   - If YES → Implement completely or as tracer with immediate usage
   
4. **Can this be simplified to deliver value faster?**
   - If YES → Start with tracer, iterate to complete

---

## Anti-Patterns to Avoid

- ❌ "Build all CRUD operations for all entities"
- ❌ "Complete the UI design system"
- ❌ "Implement full backend before any frontend"
- ❌ "Create all database migrations upfront"
- ❌ Slices that take more than 1-2 days to deliver value
- ❌ Technical debt cleanup without user-facing improvements

---

## Output Structure: Multiple Documents

The planning agent should create **separate markdown files** for organization and handoff:

### Document Zero: `00-architecture.md`

The high-level architecture document that provides project context for all vertical slices.

### Vertical Slice Documents: `01-slice-name.md`, `02-slice-name.md`, etc.

Each vertical slice gets its own detailed implementation document.

**Benefits of this approach**:
- ✅ Implementation agents receive focused, scoped instructions
- ✅ Parallel development: Multiple agents can work on different slices
- ✅ Easy to reference: "Implement slice 03"
- ✅ Version control friendly: Changes to one slice don't affect others
- ✅ Progressive disclosure: Agents only see what they need

---

## Document Zero: Architecture Overview

**Filename**: `00-architecture.md`

**Purpose**: Provides the foundational context that all implementation agents need to understand the project.

**What to Include**:

1. **Project Vision** (2-3 sentences)
   - What the project does
   - Who it's for
   - Primary value proposition

2. **System Architecture**
   - **Components**: List all major parts (frontend, backend, database, external services)
   - **Technology Stack**: Specific technologies chosen for each component
   - **Data Flow**: How information moves through the system (simple diagram or description)
   - **Key Architectural Decisions**: Important choices made and why

3. **Project Structure**
   - Directory layout
   - Where different types of code live
   - Naming conventions

4. **Development Environment**
   - Required tools and versions
   - Setup instructions
   - Environment variables needed

5. **Shared Conventions**
   - API patterns (REST structure, response formats)
   - Error handling approach
   - Authentication/authorization strategy
   - Logging and monitoring approach

6. **Vertical Slices Overview**
   - List of all slices with one-line descriptions
   - Dependencies between slices (which must be completed first)

7. **Non-Functional Requirements**
   - Performance targets
   - Security requirements
   - Accessibility standards
   - Browser/device support

**Keep It Concise**: 2-3 pages maximum. This is a reference document, not exhaustive documentation. Implementation agents should be able to scan it quickly to understand the project context.

---

## Vertical Slice Documents

**Filename Pattern**: `01-feature-name.md`, `02-feature-name.md`, etc.

**Purpose**: Provides everything an implementation agent needs to build one complete, working feature.

**What to Include**:

1. **User Value Statement**
   - Clear description of what users can DO after this slice
   - User story format: "As a [user], I want to [action] so that [benefit]"

2. **Prerequisites**
   - Which slices must be completed first
   - Reference to Document Zero for architecture context

3. **Scope - Frontend**
   - Specific components to create
   - Routes/pages needed
   - State management requirements
   - UI elements and styling approach

4. **Scope - Backend**
   - API endpoints to create (with request/response shapes)
   - Business logic to implement
   - Validation rules
   - Error handling requirements

5. **Scope - Database**
   - Tables/collections to create (with schema)
   - Indexes needed
   - Relationships to other data

6. **Scope - Integrations**
   - External APIs or services needed
   - Third-party libraries to use

7. **Implementation Approach**
   - **Tracer Phase**: Simplest end-to-end version (happy path, minimal validation, basic UI)
   - **Complete Phase**: Production-ready version (error handling, edge cases, polish, tests)

8. **Acceptance Criteria**
   - Specific, testable conditions that define "done"
   - Must include both functional and quality requirements

9. **Testing Scenarios**
   - Happy path flow
   - Error cases to handle
   - Edge cases to consider

10. **Integration Points**
    - How this connects to existing slices
    - What this provides for future slices

11. **Files to Create/Modify**
    - Explicit list of new files
    - Explicit list of files that need changes

12. **Notes for Implementation Agent**
    - Helpful tips
    - Common pitfalls to avoid
    - Any context that helps them succeed

**Critical**: Every slice must deliver **end-to-end functionality**. Include frontend + backend + database in each slice, not separated by layer.

---

## Handoff Process

When handing work to an implementation agent:

1. **Provide Document Zero**: Give `00-architecture.md` for full project context
2. **Provide Slice Document**: Give `0X-slice-name.md` for specific implementation details
3. **Simple instruction**: "Implement the vertical slice described in these documents"

**Example handoff**:
```
I need you to implement Slice 02: Dashboard View.

Context: Review 00-architecture.md for the overall system architecture.
Implementation: Follow 02-dashboard-view.md for detailed requirements.

Start with the tracer implementation to prove the concept, then iterate to the complete implementation.
```

## Benefits of This Structure

✅ **Clear separation of concerns**: Architecture vs. implementation details
✅ **Reusable context**: Document Zero is referenced by all slices
✅ **Focused work**: Implementation agents only see their slice
✅ **Easy progress tracking**: Check off slices as they're completed
✅ **Parallel development**: Multiple agents can work simultaneously
✅ **Git-friendly**: Each slice is a separate file, reducing merge conflicts
✅ **Easy updates**: Change one slice without affecting others

---

Remember: **Working software over comprehensive plans.** Every slice should result in something a user can touch, test, and benefit from.
