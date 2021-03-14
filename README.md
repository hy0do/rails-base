# rails-base

rails+nodeを動かすために必要なツールを備えたイメージ

このイメージ単体ではアプリケーションとして機能しないので、

アプリケーションを実装したリポジトリでこのイメージを参照する

```
asia.gcr.io/buzz-connection/rails-base
```


## 使用箇所

 - local
   - railsコンテナ
   - webpackerコンテナ
- production
  - user-appコンテナ
