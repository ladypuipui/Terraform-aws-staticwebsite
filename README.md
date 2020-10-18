# README #

terraformを使って、cloudfront+S3+Basic認証(リダイレクトなし)の構成を簡単に作成することができます！

### 使い方概要 ###


1. 作業環境の用意
	1. WSLの有効化(推奨)  
		・WSLを使うとクライアントPCのローカルにAWSのキーをためておくハードルが下がる  
		・ISTのIPからのアクセスになるのでもろもろ作業が楽
	 
	1. AWS cli2インストール  
		1．https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/install-cliv2-linux.html  
		2．aws configure --profile 〇〇　でクレデンシャルを登録（〇〇の部分、使います！)  
		
		  
    1. terraform インストール
		https://azukipochette.hatenablog.com/entry/2018/06/24/004354

1. setup.sh  を実行

	bash setup.sh

1. 実行結果を確認

    terraformはテスト実行までがsetup.shのお仕事です

1. terraformディレクトリへ遷移
1. terraform apply を実行

