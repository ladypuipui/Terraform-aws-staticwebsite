# README #

terraformを使って、cloudfront+S3+Basic認証(リダイレクトなし)の構成を簡単に作成することができます！

###  作れる構成 ###

![diagram](https://user-images.githubusercontent.com/54981355/96722686-9cdcf980-13e8-11eb-9e62-0bf138846b06.png)

### スクリプトの構成 ###
```

├── README.md
├── setup.sh
└── terraform
    ├── acm.tf
    ├── cloudfront.tf
    ├── iam-lambdaedge.tf
    ├── lambda
    │   ├── basic_auth
    │   │   └── index.js
    │   └── rootobject
    │       └── index.js
    ├── lambdaedge.tf
    ├── main.tf
    ├── output.tf
    └── route5

```
 
### 処理の流れ ###

1. setup.sh を実行し、変数にいろいろ入れる
	1. サイトURL、ドメイン名
	1. Basic認証のIDとPW
	1. basic認証スルーするIPアドレス
	1. AWSのクレデンシャルのプロフィール名
	1.ステージ名

1. setup.shで置換したりしてconfig準備する

1. index.htmlを作る

1. terraform init が走って設定を初期化する

1. terraform planが走ってドライラン

1. 続けていいか？聞かれるのでYes/Noで答える
	1. YES：terraform applyで本番実行
	1.NO：ここで終わり（※）

1.  [YES選んだら]オリジンバケットにindex.htmlを転送

※ここで抜けても、設定ファイルはできてるので後から実行可


### 使い方概要 ###


1. 作業環境の用意
	1. AWS cli2インストール  
		1．https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/install-cliv2-linux.html  
		2．aws configure --profile 〇〇　でクレデンシャルを登録（〇〇の部分、使います！)  	  
    	1. terraform インストール
		https://azukipochette.hatenablog.com/entry/2018/06/24/004354

1. setup.sh  を実行
```	
cd serverless-cloudfront-s3-basicauth
bash setup.sh
```
