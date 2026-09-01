#!/usr/bin/env bash
# 本地手动同步脚本（与 .github/workflows/sync.yml 逻辑一致）。
# 用法： ./sync.sh   然后自行 commit & push
set -uo pipefail
cd "$(dirname "$0")"
mkdir -p filters

download() {
  local out="$1"; local url="$2"
  echo "Downloading $out ..."
  if curl -fsSL --retry 3 --max-time 180 "$url" -o "filters/$out"; then
    echo "  OK ($(wc -l < "filters/$out") lines)"
  else
    echo "  WARN: failed $out, keeping previous version"
  fi
}

download easylist.txt        "https://easylist.to/easylist/easylist.txt"
download easylistchina.txt   "https://easylist-downloads.adblockplus.org/easylistchina.txt"
download easyprivacy.txt     "https://easylist.to/easylist/easyprivacy.txt"
download adguard_base.txt    "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_2_Base/filter.txt"
download adguard_chinese.txt "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_224_Chinese/filter.txt"

echo "Done. Commit & push manually:"
echo "  git add filters && git commit -m \"sync\" && git push"
