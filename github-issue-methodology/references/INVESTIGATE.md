# Investigation Workflow

Step-by-step process for investigating GitHub issues.

## Phase 1: Initial Assessment (15-30 minutes)

### 1.1 Read the Issue

- Understand what's broken
- Identify who's affected
- Check severity/priority labels
- Look for reproduction steps

### 1.2 Clone and Setup

```bash
# Clone the repository
git clone <repo-url>
cd <repo>

# Install dependencies
npm install
# or: pnpm install, yarn install, make setup

# Verify setup
npm test
```

### 1.3 Read Documentation

```bash
# Check for AI/developer seed documentation
cat CLAUDE.md
cat CONTRIBUTING.md
cat README.md

# Look for testing guidelines
cat .github/CONTRIBUTING.md
grep -r "test" .github/workflows/*.yml
```

**What to look for:**
- Testing framework (Jest, Vitest, Mocha, etc.)
- Test command (`npm test`, `pnpm test`, `make test`)
- Coverage requirements
- PR submission guidelines

## Phase 2: Explore Codebase (1-2 hours)

### 2.1 Find Related Code

```bash
# Search for relevant files
grep -r "relevant_function_or_class" src/

# Find test files
find . -name "*.test.ts" -o -name "*.spec.ts"

# Look for similar fixes
git log --all --grep="keyword" --oneline
```

### 2.2 Study Existing Tests

```bash
# Find test patterns in the relevant module
find src/related_module -name "*.test.ts"

# Look for test harnesses
find . -name "*harness*" -o -name "*fixture*"

# Examine test structure
cat src/related_module/feature.test.ts
```

**What to look for:**
- How tests are structured (describe/it blocks)
- How test data is generated (fixtures, factories)
- How to mock dependencies
- Coverage expectations

### 2.3 Reproduce the Bug

```bash
# Run existing tests to see current state
npm test -- related_module

# Create minimal reproduction
# Add debug logging if needed
# Trace execution path

# Verify bug exists
npm test -- --grep "reproduction_case"
```

## Phase 3: Root Cause Analysis (1-2 hours)

### 3.1 Add Diagnostic Logging

```typescript
// Add strategic logging
console.log('[DEBUG] Variable state:', variable);
console.log('[DEBUG] Execution path:', trace);
```

### 3.2 Trace Execution

- Use debugger (Chrome DevTools, VS Code debugger)
- Add breakpoints at critical paths
- Step through code to understand flow
- Identify where behavior diverges from expected

### 3.3 Identify Edge Cases

- What inputs cause failure?
- Are there platform-specific issues?
- Is it a race condition?
- Is it related to specific versions?

## Phase 4: Document Findings (30 minutes)

### 4.1 Create Investigation Report

```markdown
# Issue Investigation: <Title>

## Problem Summary
- What's broken: <concise description>
- Who's affected: <users, scenarios>
- Severity: <high/medium/low>

## Root Cause
- Expected behavior: <what should happen>
- Actual behavior: <what actually happens>
- Root cause: <technical explanation>
- Evidence: <logs, traces, code references>

## Reproduction Steps
1. Step 1
2. Step 2
3. Bug observed

## Existing Patterns Found
- Similar fix: <commit hash or PR link>
- Test harness: <file path>
- Related tests: <file paths>

## Implementation Plan
- Files to change: <list>
- Tests to write: <list>
- Breaking changes: <yes/no + details>
```

## Phase 5: Implementation Prep (15 minutes)

### 5.1 Create Feature Branch

```bash
git checkout -b fix/issue-description
```

### 5.2 Prepare Test Harness

```bash
# If test harness exists, use it
# If not, follow existing test patterns

# Create test file
cat > src/feature/bug-fix.test.ts << 'EOF'
// Test cases go here
EOF
```

## Output Checklist

Before moving to implementation, you should have:

✅ Issue understood and reproduced locally
✅ Root cause identified with evidence
✅ Existing patterns explored (tests, harnesses, similar fixes)
✅ Implementation plan documented
✅ Test harness identified or created
✅ Feature branch created

## Time Estimate

- **Phase 1**: 15-30 minutes
- **Phase 2**: 1-2 hours
- **Phase 3**: 1-2 hours
- **Phase 4**: 30 minutes
- **Phase 5**: 15 minutes

**Total**: 3-5 hours