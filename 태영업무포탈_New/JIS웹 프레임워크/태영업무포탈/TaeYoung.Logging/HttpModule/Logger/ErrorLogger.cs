using System;
using System.Collections.Generic;
using TaeYoung.Biz.Common;

namespace TaeYoung.Logging.HttpModule.Logger
{
    /// <summary>
    /// Exception 발생의 경우 오류로그를 남긴다. 
    /// </summary>
    public class ErrorLogger : IDisposable
    {
        // Request URL Setting
        public string RequestUrl = string.Empty;

        /// <summary>
        /// LogException
        /// </summary>
        /// <param name="occurTime"></param>
        /// <param name="bizType"></param>
        /// <param name="formId"></param>
        /// <param name="userIp"></param>
        /// <param name="userId"></param>
        /// <param name="ex"></param>
        public void LogException(DateTime occurTime, string bizType, string formId, string userIp, string userId, Exception ex)
        {
            this.LogException(occurTime, bizType, formId, userIp, userId, ex, string.Empty);
        }

        /// <summary>
        /// Exception 로그를 기록
        /// </summary>
        /// <param name="occurTime">발생시간</param>
        /// <param name="bizType">업무구분</param>
        /// <param name="formId">폼아이디</param>
        /// <param name="userIp">IP</param>
        /// <param name="userId">ID</param>
        /// <param name="ex">Exception</param>
        /// <param name="customMessage">메시지</param>
        public void LogException(DateTime occurTime, string bizType, string formId, string userIp, string userId, Exception ex, string customMessage)
        {
            string strLogType = LogType.Exception;
            string message = ex.Message;
            if (!string.IsNullOrEmpty(message))
            {
                // "|" 를 포함한 경우, 0004| 형식인지 확인
                bool bspecialCare = false;
                string specialMsg = string.Empty;

                // 로그가 네자리인 경우 메시지 데이터 베이스로 부터 메시지를 읽어온다. 
                if (message.Split('|')[0].Length == 4)
                {
                    string strMsgId = string.Empty;
                    // "|" 를 포함한 경우, 0004| 형식인지 확인한다. 
                    if (message.Contains("|"))
                    {
                        if (message.Split('|')[0].Length == 4)
                        {
                            strMsgId = message.Split('|')[0];
                            bspecialCare = true;
                            specialMsg = message;
                        }
                    }
                    else if (message.Length == 4)
                    {
                        strMsgId = message;
                    }

                    // strMsgId 가 할당된 경우, 즉, "|"를 포함한 "0004|" 형태거나
                    // 메시지 자리수가 네자리인 경우만 DB에서 쿼리한다. 
                    if (!string.IsNullOrEmpty(strMsgId))
                    {
                        string sBiz = string.Empty;
                        //switch (bizType)
                        //{
                        //    case BizType.Common: sBiz = MessageMainCode.Common; break;
                        //    case BizType.Approval: sBiz = MessageMainCode.Approval; break;
                        //    case BizType.GeneralLob: sBiz = MessageMainCode.ClxLob; break;
                        //}

                        //using (WS.Ribbon.Base.Component.MessageBiz msgBiz = new WS.Ribbon.Base.Component.MessageBiz())
                        //{
                        //    WS.Ribbon.Base.Type.MessageType msgType = msgBiz.GetMessageSingle(sBiz, strMsgId);
                        //    message = msgType.Korean;
                        //}

                        // "|" 를 포함한 경우, 0004| 형식인 경우 DB에서 읽은 메시지에 {0},{1} 등이 
                        // 포함되어있고, 이것을 실제 문자열로 치환해서 DB에 저장한다. 
                        if (bspecialCare)
                        {
                            string[] tempstrs = specialMsg.Split('|');
                            List<string> lstTemp = new List<string>();
                            for (int i = 1; i < tempstrs.Length; i++)
                            {
                                lstTemp.Add(tempstrs[i]);
                            }
                            message = string.Format(message, lstTemp.ToArray());
                        }
                    }// end of strMsgid check
                }
            }

            string messageDetail = string.Empty;
            // Request Url
            if (!string.IsNullOrEmpty(this.RequestUrl))
            {
                messageDetail = "<<Url>>" + this.RequestUrl + "\r\n" + "\r\n" + "\r\n";
            }

            // Custom Message

            if (string.IsNullOrEmpty(customMessage))
            {
                messageDetail += ex.StackTrace;
            }
            else
            {
                messageDetail += "<<CustomMessage>>" + customMessage + "\r\n" + "\r\n" + "\r\n" + ex.StackTrace;
            }

            // Log
            using (ExceptionLogBiz biz = new ExceptionLogBiz())
            {
                biz.InsertLog(strLogType, bizType, occurTime, formId, message, messageDetail, userIp, userId, DateTime.Now);
            }
        }

        /// <summary>
        /// 객체를 해제합니다. 
        /// </summary>
        public void Dispose()
        {
            ;
        }
    }
}
