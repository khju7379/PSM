using System;
using System.Web;

namespace TaeYoung.Logging.HttpModule.Reflash
{
    /// <summary>
    /// Postback/Refreash 상태 설정
    /// </summary>
    public class RefreshAction
    {
        /// <summary>
        /// Last Refresh Ticket Entry
        /// </summary>
        public const string LastRefreshTicketEntry = "__LASTREFRESHTICKET";
        /// <summary>
        /// Current Refresh Ticket Entry
        /// </summary>
        public const string CurrentRefreshTicketEntry = "__CURRENTREFRESHTICKET";
        /// <summary>
        /// Page Refresh Entry
        /// </summary>
        public const string PageRefreshEntry = "IsPageRefresh";
        /// <summary>
        /// 현재 티켓 슬롯 확인
        /// </summary>
        /// <param name="ctx"></param>
        public static void Check(HttpContext ctx)
        {
            // 티켓 슬롯을 초기화합니다.
            EnsureRefreshTicket(ctx);
            // 마지막으로 사용한 티켓을 세션으로부터 읽습니다.
            int lastTicket = GetLastRefreshTicket(ctx);
            // 현재 요청의 티켓을 숨겨진 필드로부터 읽습니다.
            int thisTicket = GetCurrentRefreshTicket(ctx);
            // 티켓을 비교합니다.
            if (thisTicket > lastTicket || (thisTicket == lastTicket && thisTicket == 0))
            {
                UpdateLastRefreshTicket(ctx, thisTicket);
                ctx.Items[PageRefreshEntry] = false;
            }
            else
                ctx.Items[PageRefreshEntry] = true;
        }
        /// <summary>
        /// 티켓 상태 초기화
        /// </summary>
        /// <param name="ctx">현제 페이지 HttpContext</param>
        private static void EnsureRefreshTicket(HttpContext ctx)
        {
            if (ctx.Session[LastRefreshTicketEntry] == null)
                ctx.Session[LastRefreshTicketEntry] = 0;
        }
        /// <summary>
        /// 마지막 티켓 반환
        /// </summary>
        /// <param name="ctx">현제 페이지 HttpContext</param>
        /// <returns>ID</returns>
        private static int GetLastRefreshTicket(HttpContext ctx)
        {
            return Convert.ToInt32(ctx.Session[LastRefreshTicketEntry]);
        }
        /// <summary>
        /// 이전 티켓 반환
        /// </summary>
        /// <param name="ctx">현제 페이지 HttpContext</param>
        /// <returns>ID</returns>
        private static int GetCurrentRefreshTicket(HttpContext ctx)
        {
            return Convert.ToInt32(ctx.Request[CurrentRefreshTicketEntry]);
        }
        /// <summary>
        /// 티켓 상태 UPDATE
        /// </summary>
        /// <param name="ctx">현제 페이지 HttpContext</param>
        /// <param name="ticket">ID</param>
        private static void UpdateLastRefreshTicket(HttpContext ctx, int ticket)
        {
            ctx.Session[LastRefreshTicketEntry] = ticket;
        }
    }
}