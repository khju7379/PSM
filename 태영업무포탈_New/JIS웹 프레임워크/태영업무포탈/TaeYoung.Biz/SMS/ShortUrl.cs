using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JINI.Base;
using System.Data;
using JINI.Data;
using System.Text.RegularExpressions;
using System.Security.Cryptography;
using System.IO;


namespace TaeYoung.Biz.SMS
{
    public class ShortUrl : BizBase
    {
        /// <summary>        
        /// Converts a Base-10 Integer to Base-64.  This will effectively shorten the number of characters used to represent a number > 10.          
        /// </summary>        
        public static string Shrink(int Number)
        {
            return ConvertDecToBase(Number, 64);
        }
        /// <summary>        
        /// Converts a Base-64 Number (represented as a string) into a Base-10 Integer.  This will effectively expand the numbers of characters needed to represent the number.        
        /// </summary>        
        /// <param name="NumberString"></param>        
        /// <returns></returns>        
        public static int Expand(string NumberString)
        {
            return ConvertBaseToDec(NumberString, 64);
        }
        private static string DefaultChars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

        private static string Base64Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
        private static int ConvertBaseToDec(string NumberString, int Base)
        {
            string Chars;
            if (Base == 64)
            {
                NumberString = Regex.Replace(NumberString, "^A+", "");
                Chars = Base64Chars;
            }
            else
            {
                NumberString = Regex.Replace(NumberString, "^0+", "");
                Chars = DefaultChars;
            }
            int Dec = 0;
            for (int i = 0; i <= NumberString.Length - 1; i++)
            {
                int CharNum = Chars.IndexOf(NumberString[i]);
                int Conversion = CharNum * IntPow(Base, (NumberString.Length - (i + 1)));
                Dec = Dec + Conversion;
            }
            return Dec;
        }
        private static string ConvertDecToBase(int OriginalNumber, int Base)
        {
            char[] Chars;
            if (Base == 64)
            {
                Chars = Base64Chars.ToCharArray();
            }
            else
            {
                Chars = DefaultChars.ToCharArray();
            }
            string encoded = "";
            encoded = ConvertDecToBase(OriginalNumber, Base, encoded, Chars);
            return encoded;
        }
        private static string ConvertDecToBase(int Number, int Base, string EncodedString, char[] Chars)
        {
            if (Number < Base)
            {
                EncodedString = EncodedString + Chars[Number];
            }
            else
            {
                int NewNumber = Number / Base;
                EncodedString = ConvertDecToBase(NewNumber, Base, EncodedString, Chars);
                Number = Number - (NewNumber * Base);
                if (Number < Base)
                {
                    EncodedString = EncodedString + Chars[Number];
                }
            }
            return EncodedString;
        }
        private static int IntPow(int x, int pow)
        {
            int ret = 1;
            while (pow != 0)
            {
                if ((pow & 1) == 1)
                    ret *= x;
                x *= x;
                pow >>= 1;
            }
            return ret;
        }

        #region 암호화 복호화 함수
        public static string DesEncrypt(string str)
        {
            byte[] iv = { 16, 29, 51, 112, 210, 78, 98, 186 };
            byte[] key = { 57, 129, 125, 118, 233, 60, 13, 94, 153, 156, 188, 9, 109, 20, 138, 7, 31, 221, 215, 91, 241, 82, 254, 189 };

            string encryptStr = string.Empty;

            byte[] bytIn = null;
            byte[] bytOut = null;
            MemoryStream ms = null;
            TripleDESCryptoServiceProvider tcs = null;
            ICryptoTransform ct = null;
            CryptoStream cs = null;

            try
            {

                bytIn = System.Text.Encoding.UTF8.GetBytes(str);

                ms = new MemoryStream();

                tcs = new TripleDESCryptoServiceProvider();

                ct = tcs.CreateEncryptor(key, iv);

                cs = new CryptoStream(ms, ct, CryptoStreamMode.Write);

                cs.Write(bytIn, 0, bytIn.Length);

                cs.FlushFinalBlock();

                bytOut = ms.ToArray();

                encryptStr = System.Convert.ToBase64String(bytOut, 0, bytOut.Length);
            }
            catch (Exception ex)
            {
            }
            finally
            {
                if (cs != null) { cs.Clear(); cs = null; }
                if (ct != null) { ct.Dispose(); ct = null; }
                if (tcs != null) { tcs.Clear(); tcs = null; }
                if (ms != null) { ms = null; }
            }

            return encryptStr;

        }

        //복호화
        public static string DesDecrypt(string str)
        {
            byte[] iv = { 16, 29, 51, 112, 210, 78, 98, 186 };
            byte[] key = { 57, 129, 125, 118, 233, 60, 13, 94, 153, 156, 188, 9, 109, 20, 138, 7, 31, 221, 215, 91, 241, 82, 254, 189 };

            string decryptStr = string.Empty;

            byte[] bytIn = null;
            MemoryStream ms = null;
            TripleDESCryptoServiceProvider tcs = null;
            CryptoStream cs = null;
            ICryptoTransform ct = null;
            StreamReader sr = null;

            try
            {

                bytIn = System.Convert.FromBase64String(str);
                ms = new MemoryStream(bytIn, 0, bytIn.Length);
                tcs = new TripleDESCryptoServiceProvider();
                ct = tcs.CreateDecryptor(key, iv);
                cs = new CryptoStream(ms, ct, CryptoStreamMode.Read);
                sr = new StreamReader(cs);

                decryptStr = sr.ReadToEnd();

            }
            catch (Exception ex)
            {
            }
            finally
            {
                if (sr != null) { sr.Close(); sr = null; }
                if (cs != null) { cs.Clear(); cs = null; }
                if (ct != null) { ct.Dispose(); ct = null; }
                if (tcs != null) { tcs.Clear(); tcs = null; }
                if (ms != null) { ms.Close(); ms = null; }
            }

            return decryptStr;
        }
        #endregion

        
    }
}
