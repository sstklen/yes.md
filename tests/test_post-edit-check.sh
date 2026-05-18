#!/bin/bash

# Path to the hook script
HOOK_SCRIPT="./hooks/post-edit-check.sh"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Test statistics
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Helper function to run a test
run_test() {
  local filename="$1"
  local expected_output_contains="$2"
  local test_name="Test with filename: $filename"

  ((TESTS_RUN++))

  # Run the hook script and capture output
  local output
  output=$("$HOOK_SCRIPT" "$filename")

  if [ -z "$expected_output_contains" ]; then
    # Expect empty output
    if [ -z "$output" ]; then
      echo -e "${GREEN}PASS${NC}: $test_name (Output was empty as expected)"
      ((TESTS_PASSED++))
    else
      echo -e "${RED}FAIL${NC}: $test_name"
      echo "  Expected: empty output"
      echo "  Got: '$output'"
      ((TESTS_FAILED++))
    fi
  else
    # Expect specific string in output
    if echo "$output" | grep -q "$expected_output_contains"; then
      echo -e "${GREEN}PASS${NC}: $test_name (Output contained expected string)"
      ((TESTS_PASSED++))
    else
      echo -e "${RED}FAIL${NC}: $test_name"
      echo "  Expected output to contain: '$expected_output_contains'"
      echo "  Got: '$output'"
      ((TESTS_FAILED++))
    fi
  fi
}

echo "Running tests for $HOOK_SCRIPT..."
echo "-----------------------------------"

# Test cases - Ignored files (should output nothing)
run_test "README.md" ""
run_test "docs/manual.txt" ""
run_test "app.log" ""
run_test "data.json.bak" ""
run_test "config.bak" ""

# Test cases - Code files (should output the Ripple Check reminder)
EXPECTED_STRING="YES.md Ripple Check"
run_test "main.py" "$EXPECTED_STRING"
run_test "script.sh" "$EXPECTED_STRING"
run_test "index.js" "$EXPECTED_STRING"
run_test "app/models/user.rb" "$EXPECTED_STRING"

echo "-----------------------------------"
echo "Tests run: $TESTS_RUN"
echo -e "${GREEN}Tests passed: $TESTS_PASSED${NC}"

if [ $TESTS_FAILED -gt 0 ]; then
  echo -e "${RED}Tests failed: $TESTS_FAILED${NC}"
  exit 1
else
  echo -e "${GREEN}All tests passed!${NC}"
  exit 0
fi
