namespace TaeYoung.Logging.HttpModule.Logger
{
    /// <summary>
    /// 로그타입
    /// </summary>
    public struct LogType
    {
        /// <summary>
        /// 오류
        /// </summary>
        public const string Exception = "ERROR";
        /// <summary>
        /// Audit
        /// </summary>
        public const string Audit = "AUDIT";
        /// <summary>
        /// TimeStamp
        /// </summary>
        public const string Time = "TIME";
        /// <summary>
        /// Custom Log
        /// </summary>
        public const string Custom = "CUST";
        /// <summary>
        /// Approval Log
        /// </summary>
        public const string Approval = "Approval";
    }
}
