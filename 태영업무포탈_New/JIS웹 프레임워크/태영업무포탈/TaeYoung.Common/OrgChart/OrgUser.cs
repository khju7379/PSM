using System.Collections.Specialized;

namespace TaeYoung.Common.OrgChart
{
    public class OrgUser
    {
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 1. VARIABLE
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        private string _id = null;
        private static string _langKey = "userlang";
        private static string _nameKey = "username";
        private NameValueCollection _props = new NameValueCollection();

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 2. ENUMERANCE
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 3. PROPERTY
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        /// <summary>
        /// Returns or sets the ID
        /// </summary>
        public string Id
        {
            get
            {
                return this._id;
            }
            set
            {
                this._id = value;
                this._props["id"] = value;
            }
        }

        /// <summary>
        /// Returns or sets the specified value of name
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public string this[string name]
        {
            get
            {
                return this._props[name];
            }
            set
            {
                this._props[name] = value;
            }
        }

        /// <summary>
        /// Returns or sets the key of language
        /// </summary>
        public static string LangKey
        {
            get
            {
                return _langKey;
            }
            set
            {
                _langKey = value;
            }
        }

        /// <summary>
        /// Returns or sets the key of name
        /// </summary>
        public static string NameKey
        {
            get
            {
                return _nameKey;
            }
            set
            {
                _nameKey = value;
            }
        }

        /// <summary>
        /// Returns the System.String of UIG
        /// </summary>
        public string UigString
        {
            get
            {
                return Worker.UigString(this._props);
            }
        }

        public Worker Worker
        {
            get
            {
                return new Worker(this._id, this.UigString, this._props[_nameKey]);
            }
        }

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 4. Constructor
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 5. Override Method
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 6. PRIVATE METHOD
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        // 7. PUBLIC METHOD
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        
        /// <summary>
        /// Returns the OrgUser From UIG.
        /// </summary>
        /// <param name="uig"></param>
        /// <returns></returns>
        public static OrgUser GenerateFromUig(string uig)
        {
            OrgUser user = new OrgUser();
            NameValueCollection values = Worker.UigCollection(uig);
            user.Id = values["id"];
            string[] allKeys = values.AllKeys;
            for (int i = 0; i < values.Count; i++)
            {
                string str = allKeys[i];
                string str2 = values[str];
                user[str] = str2;
            }
            return user;
        }
    }
}
