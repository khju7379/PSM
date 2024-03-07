using System;
using System.Web;
using TaeYoung.Logging.HttpModule.Reflash;

namespace TaeYoung.Logging.HttpModule
{
    /// <summary>
    /// Postback/Refreash 상태 모듈
    /// </summary>
    public class RefreshModule : IHttpModule
    {
        /// <summary>
        /// IHttpModule::Init
        /// </summary>
        /// <param name="app">HttpApplication</param>
        public void Init(HttpApplication app)
        {
            // 파이프라인 이벤트에 등록합니다.
            app.AcquireRequestState += new EventHandler(OnAcquireRequestState);
        }
        /// <summary>
        /// IHttpModule::Dispose
        /// </summary>
        public void Dispose() { }
        /// <summary>
        /// F5 또는 뒤로/앞으로 동작이 진행 중인지 확인
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void OnAcquireRequestState(object sender, EventArgs e)
        {
            // HTTP 컨텍스트에 액세스합니다.
            HttpApplication app = (HttpApplication)sender;
            HttpContext ctx = app.Context;
            // F5 동작을 확인합니다.
            RefreshAction.Check(ctx);
            return;
        }

    }

}