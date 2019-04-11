# ***********************************************
#
# ログローテート処理
# 圧縮形式：.gz
#
# ***********************************************

# ログ格納ディレクトリ
LOG_DIR='/usr/local/apache-tomcat-8.5.29/logs/'

# 拡張子
EXT='.out'

# 圧縮拡張子
COMP_EXT='.gz'


### 31日以前のファイル削除
dltLmtDate=`date -d '3 months ago' +'%Y%m%d'`

for gzFile in `ls ${LOG_DIR}catalina*${COMP_EXT} 2> /dev/null`
do

  # ファイルの日付から90日以前か判断
  fileDate=`echo ${gzFile} | sed "s/.*\([0-9]\{4\}\)\([0-1][0-9]\)\([0-3][0-9]\).*/\\\\1\\\\2\\\\3/g"`

  # ファイルから日付が抽出できたか
  date -d "${fileDate}" 1> /dev/null 2>&1

  if [ $? -ne 0 ]; then
    # 日付の抽出が出来なかった場合はスキップ
    continue
  fi

  # 日付を比較し31日以前であれば削除
  if [ ${dltLmtDate} -gt ${fileDate} ]; then
    rm -f ${gzFile}
  fi

done


### 圧縮処理
execDate=`date +'%Y%m%d'`
#rename gz file
newFileName=${LOG_DIR}catalina"-${execDate}${COMP_EXT}"
# 処理日以前かつ未圧縮のファイルのみ抽出
for logFile in `ls ${LOG_DIR}catalina"${EXT}" | grep -v "${execDate}"`
do
  # 圧縮
  #gzip -f -S "-${execDate}${COMP_EXT}" ${newFileName}
  gzip -cvf ${logFile} > ${newFileName}
  # empty content of {logFile}
  :> "${logFile}"

  if [ $? -ne 0 ]; then
    # 圧縮処理失敗
    :
  fi

done

# make default file log
#echo '' > "${LOG_DIR}"catalina"${EXT}"
# change permision for user tomcat
chown -R tomcat:tomcat "${newFileName}"
#chmod -R 0640 "${LOG_DIR}"catalina"${EXT}"
