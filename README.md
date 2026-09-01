# nplyr/adblock

nPlyr 浏览器内置广告拦截规则的**镜像仓库**。

每天由 GitHub Action（`.github/workflows/sync.yml`）从上游公开订阅源抓取最新规则并提交到
`filters/`。nPlyr App 通过

```
https://raw.githubusercontent.com/nplyr/adblock/main/filters/<name>.txt
```

拉取，避免直接依赖上游站点（稳定性 / 可达性）。

## 订阅源映射

| 仓库内文件 | 上游源 |
|---|---|
| `filters/easylist.txt` | https://easylist.to/easylist/easylist.txt |
| `filters/easylistchina.txt` | https://easylist-downloads.adblockplus.org/easylistchina.txt |
| `filters/easyprivacy.txt` | https://easylist.to/easylist/easyprivacy.txt |
| `filters/adguard_base.txt` | https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_2_Base/filter.txt |
| `filters/adguard_chinese.txt` | https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_224_Chinese/filter.txt |

## 同步机制

- **自动**：UTC 每天 18:00（北京时间 02:00）由 `sync.yml` 运行；下载失败保留旧版本，不破坏已有规则。
- **手动**：在 Actions 页面点 `Run workflow`，或本地执行 `./sync.sh` 后自行 commit & push。

## 在 nPlyr 中使用

App 的 `Core/Browser/AdBlock/AdBlockSubscription.swift` 内置源 `url` 已指向本仓库的
`raw.githubusercontent.com/nplyr/adblock/main/filters/...`。首次使用前请先让 Action 至少成功
运行一次，确保 `filters/` 下所有文件已生成。

## 目录说明

```
nplyr-adblock/
├── .github/workflows/sync.yml   # 每日自动同步
├── sync.sh                      # 本地手动同步脚本
├── filters/                     # 下载好的规则（会被提交进仓库）
└── README.md
```
