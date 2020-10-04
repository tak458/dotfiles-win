param(
  [String]$in,
  [String]$out,
  [String]$from = "Shift-JIS",
  [String]$to = "UTF-8"
)

    # 引数$from、$toから、文字コードを表すEncodingオブジェクトを生成
$enc_f = [Text.Encoding]::GetEncoding($from)
$enc_t = New-Object "System.Text.UTF8Encoding" -ArgumentList @($false)
    # 与えられたパス（c:\tmp\convert）から合致するファイルリストを再帰的に取得
  Get-ChildItem $in -recurse |
    # 取得したファイルを順番に処理
    ForEach-Object {
    # 取得したオブジェクトがファイルの場合のみ処理（フォルダの場合はスキップ）
      if($_.GetType().Name -eq "FileInfo"){
    # 変換元ファイルをStreamReaderオブジェクトで読み込み
        $reader = New-Object IO.StreamReader($_.FullName, $enc_f)
    # 保存先のパス、保存先の親フォルダのパスを生成
        $o_path = $_.FullName.Replace($in, $out)
        $o_folder = Split-Path $o_path -parent
    # 保存先のフォルダが存在しない場合にフォルダを自動生成
        if(!(Test-Path $o_folder)){
          [Void][IO.Directory]::CreateDirectory($o_folder)
        }
    # 保存先ファイルをStreamWriterオブジェクトでオープン
        $writer = New-Object IO.StreamWriter($o_path, $false, $enc_t)
    # 変換元ファイルを順に読み込み、保存先ファイルに書き込み
        $writer.Write($reader.ReadToEnd());
    # ファイルをすべてクローズ
        $reader.Close()
        $writer.Close()
      }
    }
