import subprocess
import pytest
import os

SCRIPT_PATH = os.path.join(os.path.dirname(__file__), "..", "hooks", "pre-bash-guard.sh")

def run_script(cmd: str) -> subprocess.CompletedProcess:
    return subprocess.run([SCRIPT_PATH, cmd], capture_output=True, text=True)

class TestPreBashGuard:
    @pytest.mark.parametrize("safe_cmd", [
        "ls -la",
        "echo 'hello'",
        "cat file.txt",
        "git status",
        "git push",
        "git clean -n",
        "SELECT * FROM users",
    ])
    def test_safe_commands(self, safe_cmd: str):
        result = run_script(safe_cmd)
        assert result.returncode == 0
        assert "🚨 YES.md BLOCKED" not in result.stdout

    @pytest.mark.parametrize("dangerous_cmd", [
        "rm -rf /",
        "rm -rf *",
        "rm -rf .",
        "git reset --hard",
        "git clean -fd",
        "git checkout -- .",
        "git push --force",
        "git push -f",
        "DROP TABLE users",
        "DROP DATABASE mydb",
        "TRUNCATE table_name",
        "echo test > /dev/sda",
        "mkfs.ext4 /dev/sda1",
        ":(){:|:&};:",
        "rm -RF /", # test case insensitivity
        "drop table users", # test case insensitivity
    ])
    def test_dangerous_commands(self, dangerous_cmd: str):
        result = run_script(dangerous_cmd)
        assert result.returncode == 1
        assert "🚨 YES.md BLOCKED — dangerous command detected" in result.stdout
        assert "Matched:" in result.stdout
