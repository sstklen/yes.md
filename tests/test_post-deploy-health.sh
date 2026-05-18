#!/bin/bash

# Test script for hooks/post-deploy-health.sh

SCRIPT_PATH="../hooks/post-deploy-health.sh"
# Change to the script's directory so relative paths work
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_PATH="$DIR/../hooks/post-deploy-health.sh"

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

FAILED=0

# Helper function to run a test
run_test() {
    local test_name="$1"
    local command="$2"
    local should_trigger="$3"

    echo "Running test: $test_name"

    # Run the script and capture output
    output=$("$SCRIPT_PATH" "$command")

    # Check if output contains the expected health check string
    if echo "$output" | grep -q "Deploy Health Check"; then
        triggered=true
    else
        triggered=false
    fi

    if [ "$triggered" = "$should_trigger" ]; then
        echo -e "${GREEN}PASS${NC}"
    else
        echo -e "${RED}FAIL${NC}: expected trigger=$should_trigger but got trigger=$triggered for command '$command'"
        FAILED=1
    fi
}

echo "=== Testing post-deploy-health.sh ==="

# Tests that SHOULD trigger the health check
run_test "docker compose up" "docker compose up -d" true
run_test "docker-compose up" "docker-compose up --build" true
run_test "deploy command" "npm run deploy" true
run_test "push to production" "git push origin production" true
run_test "push to main" "git push origin main" true
run_test "uppercase docker compose" "DOCKER COMPOSE UP" true
run_test "mixed case deploy" "DePlOy" true

# Tests that SHOULD NOT trigger the health check
run_test "docker ps" "docker ps" false
run_test "docker logs" "docker logs my-container" false
run_test "git push feature" "git push origin feature-branch" false
run_test "empty command" "" false
run_test "ls command" "ls -la" false
run_test "git status" "git status" false

echo "====================================="
if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed.${NC}"
    exit 1
fi
