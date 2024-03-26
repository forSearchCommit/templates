using ExcelDataReader;
using Newtonsoft.Json;
using OfficeOpenXml;
using Promotion.Common.Utils;
using Promotion.Data.Entity;
using Promotion.Data.Entity.Type;
using PromotionBOAPI.Helper;
using PromotionBOAPI.Models;
using PromotionBOAPI.Models.Spw;
using PromotionBOAPI.Models.Slot;
using PromotionBOAPI.Service;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.Http;
using System.Globalization;

namespace PromotionBOAPI.Controllers
{
    [RoutePrefix("api/Slot")]
    public class SlotController : BaseController
    {
        #region History & Export
        [MenuAccessFilter(MenuAccessId = enMenuAccessId.View_Draw)]
        [HttpGet]
        [Route("SlotSummary")]
        public HttpResponseMessage SlotSummary([FromUri] reqSummaryMdl req)
        {
            var list = SlotService.SlotSummary(req);
            var responseBody = new { Data = list, IsSuccess = true };

            return returnResponse(null, responseBody);
        }

        [MenuAccessFilter(MenuAccessId = enMenuAccessId.View_Draw)]
        [HttpGet]
        [Route("Result")]
        public HttpResponseMessage DrawResult([FromUri] reqSlotDrawResultMdl req)
        {
            var list = SlotService.DrawResult(req);
            var responseBody = new { Data = list, IsSuccess = true };

            return returnResponse(null, responseBody);
        }

        [MenuAccessFilter(MenuAccessId = enMenuAccessId.Export_Reward_Winners)]
        [HttpGet]
        [Route("Export")]
        public HttpResponseMessage Export([FromUri] reqSlotExportMdl param)
        {
            var result = Request.CreateResponse(HttpStatusCode.OK);

            var req = new reqSlotDrawResultMdl()
            {
                Id = param.Id,
                Code = param.Code,
                Currency = param.Currency,
                Pid = param.Pid,
                VIPLevel = param.Vip,
                Page = 0
            };

            var list = SlotService.DrawResult(req);

            ExcelPackage Ep = new ExcelPackage();
            ExcelWorksheet Sheet = Ep.Workbook.Worksheets.Add("Report");

            #region Headers
            Sheet.Cells["A1"].Value = "Id";
            Sheet.Cells["B1"].Value = "Member Code";
            Sheet.Cells["C1"].Value = "Vip Level";
            Sheet.Cells["D1"].Value = "Currency";
            Sheet.Cells["E1"].Value = "Prize Name";
            Sheet.Cells["F1"].Value = "Prize Rank";
            Sheet.Cells["G1"].Value = "Spin No";
            Sheet.Cells["H1"].Value = "Spin Result";
            Sheet.Cells["I1"].Value = "Amt";
            Sheet.Cells["J1"].Value = "Churn";
            Sheet.Cells["K1"].Value = "Spin Date";
            #endregion

            if (list.Count > 0)
            {
                #region Body
                int row = 2;
                foreach (var x in list)
                {
                    Sheet.Cells[string.Format("A{0}", row)].Value = x.Id;
                    Sheet.Cells[string.Format("B{0}", row)].Value = x.MbrCode;
                    Sheet.Cells[string.Format("C{0}", row)].Value = x.VIPLevel;
                    Sheet.Cells[string.Format("D{0}", row)].Value = x.Currency;
                    Sheet.Cells[string.Format("E{0}", row)].Value = x.PrizeName;
                    Sheet.Cells[string.Format("F{0}", row)].Value = x.PrizeRank;
                    Sheet.Cells[string.Format("G{0}", row)].Value = x.RoundNo;
                    Sheet.Cells[string.Format("H{0}", row)].Value = x.SpinResult;
                    Sheet.Cells[string.Format("I{0}", row)].Value = x.Amount;
                    Sheet.Cells[string.Format("J{0}", row)].Value = x.ChurnMultiplier;
                    Sheet.Cells[string.Format("K{0}", row)].Value = ConversionHelper.ConvertToCampaignDatetime(x.ClaimedDate).ToString("yyyy/MM/dd HH:mm:ss");

                    row++;
                }
                Sheet.Cells["A:AZ"].AutoFitColumns();
                #endregion
            }

            result.Content = new ByteArrayContent(Ep.GetAsByteArray());
            result.Content.Headers.ContentType = new MediaTypeHeaderValue("application/vnd.ms-excel");
            result.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment")
            {
                FileName = "DrawResultReport.xlsx"
            };

            return result;
        }
        #endregion

        #region Draw List
        /// <summary>
        /// Get List of SpinWheel
        /// </summary>
        [MenuAccessFilter(MenuAccessId = enMenuAccessId.View_Draw)]
        [HttpGet]
        [Route("CampaignDetails")]
        public HttpResponseMessage DrawList([FromUri] reqSpwDrawListMdl param)
        {
            param = param ?? new reqSpwDrawListMdl();

            var list = SpwService.DrawList(param, out int totalRecord);
            var responseBody = new { Data = list, TotalRecord = totalRecord };

            return returnResponse(null, responseBody);
        }

        #endregion

        //#region Status
        //[HttpGet]
        //[Route("Status")]
        //public HttpResponseMessage GetStatus([FromUri] string Id, bool Rd)
        //{
        //    var responseBody = new respSpwWheelCfgMdl() { IsSuccess = false };

        //    // Rd = IsImportRandDrawCheck
        //    var errorCode = Rd ? drawStatusValidationForImportRandDraw(long.Parse(Id)) : drawStatusValidation(long.Parse(Id));

        //    if (errorCode.HasValue)
        //    {
        //        return returnResponse(null, responseBody);
        //    }

        //    responseBody.IsSuccess = true;
        //    return returnResponse(null, responseBody);
        //}

        //#endregion


        #region New Draw
        /// <summary>
        /// New Draw
        /// </summary>
        /// 
        [MenuAccessFilter(MenuAccessId = enMenuAccessId.Add_Draw)]
        [HttpPost]
        [Route("NewDraw")]
        /*public HttpResponseMessage NewDraw([FromBody] reqSlotPrizeNewModel req)*/
        public HttpResponseMessage NewDraw([FromBody] reqAddNewDrawMdl req)
        {
            var responseBody = new CommonActionResponse() { IsSuccess = false };

            var userdetails = UserHelper.GetCurrentUser();
            enErrorCode? errorCode = null;

            if (req == null)
            {
                errorCode = enErrorCode.Request_Invalid;
                return returnResponse(errorCode, responseBody);
            }

            errorCode = AddDrawValidation(req);
            if (errorCode.HasValue)
            {
                return returnResponse(errorCode, responseBody);
            }

            var dtoCamp = new tblCampaignDetails()
            {
                CampaignId = (long)req.CampaignId,
                TransactionId = GetUniNo(),
                DrawDate = ((DateTime)req.StartDate).Date,
                PreStart = ConversionHelper.ConvertToUTCCampaignDatetime(req.PreStart.Value),
                StartDate = ConversionHelper.ConvertToUTCCampaignDatetime(req.StartDate.Value),
                EndDate = ConversionHelper.ConvertToUTCCampaignDatetime(req.EndDate.Value),
                Status = (int)enDrawStatus.Pending,
            };

            var dtoStake = new tblStakeDetail()
            {
                stakeDtFrom = DateTime.Now,
                stakeDtTo = DateTime.Now
            };

            req.FreeSpin.GetSeparatedStakeInfo(userdetails.UserId);

            if (SlotService.NewDraw(req, dtoCamp, userdetails.UserId, dtoStake))
            {
                responseBody.IsSuccess = true;
            }
            else
            {
                ResponseInternalServerError();
            }

            return returnResponse(errorCode, responseBody);
        }

        #region Import Prize
        [MenuAccessFilter(MenuAccessId = enMenuAccessId.Import_Reward_Member)]
        [HttpPost] // 
        [Route("ImportPrizePreview")]
        public HttpResponseMessage ImportPrizePreview()
        {
            var responseBody = new respSlotImportWiningCombinationsModel()
            {
                IsSuccess = false,
                ImportedRandSpunList = new reqSlotImportWiningCombinationsMdl()
                {
                    windCombinationList = new List<reqSlotWCombinationListMdl>(),
                    prizeDrawList = new List<reqSlotRandPrizeListMdl>(),
                    consolationList = new List<reqConsolationListMdl>()
                }
            };

            enErrorCode? errorCode = null;
            try
            {
                //List<reqSlotImportPrizeMdl> req = new List<reqSlotImportPrizeMdl>;
                //var DrawId = HttpContext.Current.Request.Form.GetValues("DrawId").FirstOrDefault();

                //if (DrawId == null)
                //{
                //    errorCode = enErrorCode.SLOT_Import_Error;
                //    return returnResponse(errorCode, responseBody);
                //}

                HttpPostedFile Inputfile = HttpContext.Current.Request.Files[0];

                if (Inputfile == null)
                {
                    errorCode = enErrorCode.SLOT_Import_InvalidFile;
                    return returnResponse(errorCode, responseBody);
                }

                Stream FileStream = Inputfile.InputStream;

                if (FileStream == null)
                {
                    errorCode = enErrorCode.SLOT_Import_InvalidFile;
                    return returnResponse(errorCode, responseBody);
                }

                // File format validation
                IExcelDataReader reader = null;
                if (Inputfile.FileName.EndsWith(".xls"))
                {
                    reader = ExcelReaderFactory.CreateBinaryReader(FileStream);
                }
                else if (Inputfile.FileName.EndsWith(".xlsx"))
                {
                    reader = ExcelReaderFactory.CreateOpenXmlReader(FileStream);
                }
                else
                {
                    errorCode = enErrorCode.SLOT_Import_FileFormatNotSupport;
                    return returnResponse(errorCode, responseBody);
                }

                //public DataTable CreateDataTable()
                //{
                //    // Create a DataTable with columns

                //}
                //if (reader != null && !errorCode.HasValue)
                if (reader != null && !errorCode.HasValue)
                {
                    DataSet dsexcelRecords = reader.AsDataSet();
                    reader.Close();

                    if (dsexcelRecords != null && dsexcelRecords.Tables.Count >= 2)
                    {
                        // Assuming that Sheet1 and Sheet2 are the first two sheets
                        DataTable dtSheet1 = dsexcelRecords.Tables[0];
                        DataTable dtSheet2 = dsexcelRecords.Tables[1];
                        DataTable dtSheet3 = dsexcelRecords.Tables[2];

                        reqSlotWCombinationListMdl itm = null;
                        reqSlotRandPrizeListMdl itm2 = null;
                        reqConsolationListMdl itm3 = null;
                        #region
                        // Read data from Sheet1
                        foreach (DataRow dr1 in dtSheet1.Rows.Cast<DataRow>().Skip(1))
                        {
                            //responseBody.ImportedRandSpunList.randDrawList.Add(new reqSlotWCombinationListMdl()
                            itm = new reqSlotWCombinationListMdl()
                            {
                                ColumnA = dr1[0].ToString().Trim(),
                                ColumnB = dr1[1].ToString().Trim(),
                                ColumnC = dr1[2].ToString().Trim(),
                                PrizeName = dr1[3].ToString().Trim(),
                                NewSysmboldata = string.Empty

                        };
                            if(!string.IsNullOrEmpty(itm.ColumnA) && !string.IsNullOrEmpty(itm.ColumnB) && !string.IsNullOrEmpty(itm.ColumnC))
                            {
                                string BonusRMBdouble = $"{itm.ColumnA}{itm.ColumnB}{itm.ColumnC}";
                                itm.NewSysmboldata = BonusRMBdouble;
                            }
                            else
                            {
                                errorCode = enErrorCode.SLOT_Import_InvalidSysmbolValue;
                                return returnResponse(errorCode, responseBody);

                            }
                            List<Slot_WinCombineList> winCombinationList = SlotService.WinCombinationList();
                            HashSet<string> winCombinationCodes = new HashSet<string>(winCombinationList.Select(w => w.Code));

                            if (!winCombinationCodes.Contains(itm.NewSysmboldata))
                            {
                                errorCode = enErrorCode.SLOT_Import_InvalidSysmbolValue;
                                return returnResponse(errorCode, responseBody);
                            }

                            responseBody.ImportedRandSpunList.windCombinationList.Add(itm);

                        }
                        // Read data from Sheet3
                        foreach (DataRow dr2 in dtSheet3.Rows.Cast<DataRow>().Skip(1))
                        {
                            //responseBody.ImportedRandSpunList.randDrawList.Add(new reqSlotWCombinationListMdl()
                            itm3 = new reqConsolationListMdl()
                            {
                                PrizeName = dr2[0].ToString().Trim(),
                                BonusRMB = double.Parse(dr2[1].ToString().Trim()),
                                BonusUSDT = double.Parse(dr2[2].ToString().Trim()),
                                ChurnRollover = int.Parse(dr2[3].ToString().Trim())
                            };

                            responseBody.ImportedRandSpunList.consolationList.Add(itm3);
                        }
                        //checking for Consolation Prize sheet not empty, at least one prizename must empty,
                        bool isSheet3NotEmpty = dtSheet3.AsEnumerable().Any(row => row.ItemArray.Any(field => !string.IsNullOrWhiteSpace(field?.ToString())));
                        bool isAtLeastOnePrizeNameEmptyInWinConsolation = false;

                        foreach (DataRow dr1 in dtSheet1.Rows.Cast<DataRow>().Skip(1))
                        {
                            itm = new reqSlotWCombinationListMdl()
                            {
                                // ... existing assignments ...
                                PrizeName = dr1[3].ToString().Trim(),
                                // ... other properties ...
                            };

                            // Check for empty PrizeName
                            if (string.IsNullOrWhiteSpace(itm.PrizeName))
                            {
                                isAtLeastOnePrizeNameEmptyInWinConsolation = true;
                            }
                        }

                        if (isSheet3NotEmpty && !isAtLeastOnePrizeNameEmptyInWinConsolation)
                        {
                            errorCode = enErrorCode.SLOT_Import_PrizeNameAtLeastOneEmpty;
                            return returnResponse(errorCode, responseBody);
                        }

                        // Read data from Sheet2
                        foreach (DataRow dr in dtSheet2.Rows.Cast<DataRow>().Skip(1))
                        {
                            //responseBody.ImportedRandSpunList.randDrawList2.Add(new reqSlotRandPrizeListMdl()
                            itm2 = new reqSlotRandPrizeListMdl()
                            {
                                PrizeName = dr[0].ToString().Trim(),
                                Qty = int.Parse(dr[1].ToString().Trim()),
                                RandAssign = dr[5].ToString().Trim(),
                                Rank = int.Parse(dr[6].ToString().Trim()),

                                BonusRMB = null,
                                BonusUSDT = null,
                               ChurnRollover = null
                            };
                            string BonusRMBdouble = dr[2].ToString().Trim();
                            if (!string.IsNullOrEmpty(BonusRMBdouble) && double.TryParse(BonusRMBdouble, out double BonusRMBValue))
                            {
                                itm2.BonusRMB = BonusRMBValue;
                            }
                            string BonusUSDTdouble = dr[3].ToString().Trim();
                            if (!string.IsNullOrEmpty(BonusUSDTdouble) && double.TryParse(BonusUSDTdouble, out double BonusUSDTValue))
                            {
                                itm2.BonusUSDT = BonusUSDTValue;
                            }
                            string churnRolloverString = dr[4].ToString().Trim();
                            if (!string.IsNullOrEmpty(churnRolloverString) && int.TryParse(churnRolloverString, out int churnRolloverValue))
                            {
                                itm2.ChurnRollover = churnRolloverValue;
                            }


                            //bonus rmb dr[2]
                            if (!string.IsNullOrEmpty(itm2.BonusRMB.ToString()))
                            {
                                if (itm2.ChurnRollover < 0)
                                {
                                    errorCode = enErrorCode.SLOT_Import_InvalidBonusRMB;
                                    return returnResponse(errorCode, responseBody);
                                }
                            }
                            //bonus USDT dr[3]
                            if (!string.IsNullOrEmpty(itm2.BonusUSDT.ToString()))
                            {
                                if (itm2.ChurnRollover < 0)
                                {
                                    errorCode = enErrorCode.SLOT_Import_InvalidBonusUSDT;
                                    return returnResponse(errorCode, responseBody);
                                }
                            }
                            //ChurnRollover dr[4]
                            if (!string.IsNullOrEmpty(itm2.ChurnRollover.ToString()))
                            {
                                if (itm2.BonusRMB < 0 || itm2.BonusUSDT < 0)
                                {
                                    errorCode = enErrorCode.SLOT_Import_InvalidChurnRollover;
                                    return returnResponse(errorCode, responseBody);
                                }
                            }
                            //Random Assign
                            if (!string.IsNullOrEmpty(itm2.RandAssign.ToString()))
                            {
                                bool flag = true;

                                string value = itm2.RandAssign.ToString().Trim(); // Trim to remove leading/trailing spaces
                                if (string.Equals(value, "True", StringComparison.OrdinalIgnoreCase))
                                {
                                    itm2.RandAssign = "True";
                                }
                                else if (string.Equals(value, "False", StringComparison.OrdinalIgnoreCase))
                                {
                                    itm2.RandAssign = "False";
                                }
                                else
                                {
                                    errorCode = enErrorCode.SLOT_Import_InvalidRandomAssign;
                                    return returnResponse(errorCode, responseBody);
                                }

                                if (itm2.RandAssign == "True")
                                {
                                    itm2.RandAssign = "1";
                                }
                                else
                                {
                                    itm2.RandAssign = "0";
                                }
                            }
                            //PrizeName
                            string prizeNameToCheck = itm2.PrizeName;
                            HashSet<string> sheet1PrizeNames = new HashSet<string>();
                            foreach (DataRow dr1 in dtSheet1.AsEnumerable().Skip(1))
                            {
                                string prizeName = dr1[3].ToString().Trim(); // Make sure the column name matches exactly
                                sheet1PrizeNames.Add(prizeName);
                            }
                            if (!sheet1PrizeNames.Contains(prizeNameToCheck))
                            {
                                errorCode = enErrorCode.SLOT_Import_InvalidPrizeName;
                                return returnResponse(errorCode, responseBody);
                            }


                            //Rank
                            if (!string.IsNullOrEmpty(itm2.PrizeName.ToString().Trim()))
                            {
                                if (itm2.Rank < 0 || itm2.BonusRMB < 0 || itm2.BonusUSDT < 0)
                                {
                                    errorCode = enErrorCode.SLOT_Import_InvalidRank;
                                    return returnResponse(errorCode, responseBody);
                                }
                                if (!int.TryParse(itm2.Rank.ToString(), out int rankValue))
                                {
                                    errorCode = enErrorCode.SLOT_Import_InvalidRank;
                                    return returnResponse(errorCode, responseBody);
                                }
                            }
                            else
                            {
                                // Handle the case where either of the values is empty (prompt an error, set default values, etc.).
                                errorCode = enErrorCode.SLOT_Import_InvalidRank;
                                return returnResponse(errorCode, responseBody);
                            }

                            //Dictionary<string, int> sheet1Quantities = new Dictionary<string, int>();

                            //Qty
                            // Populate the dictionary with quantities from Sheet1
                            //string prizeNameToCheck = itm2.PrizeName;
                            //HashSet<string> sheet1PrizeNames = new HashSet<string>();
                            //foreach (DataRow dr1 in dtSheet1.AsEnumerable().Skip(1))
                            //{
                            //    string prizeName = dr1[3].ToString().Trim(); // Make sure the column name matches exactly
                            //    sheet1PrizeNames.Add(prizeName);
                            //}

                            //foreach (DataRow sheet1Row in dtSheet1.Rows)
                            //{
                            //    string prizeName = sheet1Row.Field<string>("PrizeName");

                            //    if (sheet1Quantities.ContainsKey(prizeName))
                            //    {
                            //        sheet1Quantities[prizeName]++;
                            //    }
                            //    else
                            //    {
                            //        sheet1Quantities.Add(prizeName, 1);
                            //    }
                            //}

                            Dictionary<string, int> sheet1PrizeCounts = new Dictionary<string, int>();
                            foreach (DataRow dr1 in dtSheet1.AsEnumerable().Skip(1))
                            {
                                string prizeName = dr1[3].ToString().Trim();
                                if (sheet1PrizeCounts.ContainsKey(prizeName))
                                {
                                    sheet1PrizeCounts[prizeName]++;
                                }
                                else
                                {
                                    sheet1PrizeCounts[prizeName] = 1; // Start counting from 1 for a new prize name
                                }
                            }

                            string prizeNameToCheck2 = itm2.PrizeName;
                            string prizeNameToCheck1 = itm.PrizeName;
                            int quantityToCheck = itm2.Qty;

                            // Check if the PrizeName from itm2 exists in Sheet1
                            if (sheet1PrizeCounts.TryGetValue(prizeNameToCheck2, out int sheet1Quantity))
                            {
                                // Compare the quantity in Sheet1 with the quantity in Sheet2
                                if (sheet1Quantity > quantityToCheck)
                                {
                                    errorCode = enErrorCode.SLOT_Import_InvalidQty;
                                    return returnResponse(errorCode, responseBody);
                                }
                            }
                            else
                            {
                                errorCode = enErrorCode.SLOT_Import_InvalidQty;
                                return returnResponse(errorCode, responseBody);
                            }

                            //check sheet2 prizename have, sheet1 also need have else wrong
                            HashSet<string> sheet1PrizeNamestest = new HashSet<string>();
                            foreach (var item in responseBody.ImportedRandSpunList.windCombinationList)
                            {
                                sheet1PrizeNamestest.Add(item.PrizeName);
                            }

                            if (!sheet1PrizeNamestest.Contains(prizeNameToCheck2))
                            {
                                errorCode = enErrorCode.SLOT_Import_WinConsolationPrizeNameNotMatch;
                                return returnResponse(errorCode, responseBody);
                            }

                            responseBody.ImportedRandSpunList.prizeDrawList.Add(itm2);

                        }

                        #endregion
                        //}

                        //responseBody.ImportedRandDrawList.randDrawList = new List<reqSpwRandDrawListMdl>();
                        //responseBody.ImportedRandDrawList.randDrawList.Add(new reqSpwRandDrawListMdl() { PrizeName = reqRandDraw.;
                        //responseBody.ImportedRandSpunList.DrawId = DrawId;
                        responseBody.IsImportValid = true;
                        responseBody.IsSuccess = true;

                    }


                }
                else
                {
                    errorCode = enErrorCode.SLOT_Import_InvalidFile;
                }


                    return returnResponse(errorCode, responseBody);
                }
            catch (Exception ex)
            {
                responseBody.IsImportValid = false;
                errorCode = enErrorCode.SLOT_Import_InvalidFile;
                return returnResponse(errorCode, responseBody);
            }

        }

        private void ImportPrizeData(reqSlotImportWiningCombinationsMdl req)
        {
            var responseBody = new CommonActionResponse() { IsSuccess = false };

            var userdetails = UserHelper.GetCurrentUser();
            enErrorCode? errorCode = null;

            if (req == null)
            {
                errorCode = enErrorCode.Request_Invalid;
                //return returnResponse(errorCode, responseBody);
            }

            if (req.IsValid == 0)
            {
                errorCode = enErrorCode.Request_Invalid;
                //return returnResponse(errorCode, responseBody);
            }

            if (SlotService.ImportWinCom(req, userdetails.UserId))
            {
                responseBody.IsSuccess = true;
                errorCode = enErrorCode.Request_Invalid;
            }
            else
            {
                ResponseInternalServerError();
            }

            //return returnResponse(errorCode, responseBody);
        }

        [MenuAccessFilter(MenuAccessId = enMenuAccessId.Import_Reward_Member)]
        [HttpPost]
        [Route("ImportMemberPreview")]
       public HttpResponseMessage ImportMemberPreview()
        {
            var responseBody = new reqSlotImportMdl()
            {
                IsSuccess = false,
                Prize = new List<reqSlotPrizeListMdl>()

            };

                var userdetails = UserHelper.GetCurrentUser();
                enErrorCode? errorCode = null;
                try
                {
                    //if (req == null)
                    //{
                    //    errorCode = enErrorCode.Request_Invalid;
                    //    return returnResponse(errorCode, responseBody);
                    //}

                    //if (req.isValid == 0)
                    //{
                    //    errorCode = enErrorCode.Request_Invalid;
                    //    return returnResponse(errorCode, responseBody);
                    //}
                    var DrawId = HttpContext.Current.Request.Form.GetValues("DrawId").FirstOrDefault();
                responseBody.DrawId = DrawId;

                if (DrawId == null)
                    {
                        errorCode = enErrorCode.SLOT_Import_Error;
                        return returnResponse(errorCode, responseBody);
                    }

                    HttpPostedFile Inputfile = HttpContext.Current.Request.Files[0];

                    if (Inputfile == null)
                    {
                        errorCode = enErrorCode.SLOT_Import_InvalidFile;
                        return returnResponse(errorCode, responseBody);
                    }

                    Stream FileStream = Inputfile.InputStream;

                    if (FileStream == null)
                    {
                        errorCode = enErrorCode.SLOT_Import_InvalidFile;
                        return returnResponse(errorCode, responseBody);
                    }

                    // File format validation
                    IExcelDataReader reader = null;
                    if (Inputfile.FileName.EndsWith(".xls"))
                    {
                        reader = ExcelReaderFactory.CreateBinaryReader(FileStream);
                    }
                    else if (Inputfile.FileName.EndsWith(".xlsx"))
                    {
                        reader = ExcelReaderFactory.CreateOpenXmlReader(FileStream);
                    }
                    else
                    {
                        errorCode = enErrorCode.SLOT_Import_FileFormatNotSupport;
                        return returnResponse(errorCode, responseBody);
                    }
                    DataSet dsexcelRecords = reader.AsDataSet();
                    reader.Close();
                    reqSlotPrizeListMdl itm = null;
                    //Read data from Sheet1
                    DataTable dtSheet1 = dsexcelRecords.Tables[0];

                    foreach (DataRow dr1 in dtSheet1.Rows.Cast<DataRow>().Skip(1))
                    {
                        //responseBody.ImportedRandSpunList.randDrawList.Add(new reqSlotWCombinationListMdl()
                        itm = new reqSlotPrizeListMdl()
                        {
                            LoginName = dr1[0].ToString().Trim(),
                            VipLevel = dr1[1].ToString().Trim(),
                            Currency = dr1[2].ToString().Trim(),
                            SpinCode1 = dr1[3].ToString().Trim(),
                            SpinPrize1 = dr1[4].ToString().Trim(),
                            SpinCode2 = dr1[5].ToString().Trim(),
                            SpinPrize2 = dr1[6].ToString().Trim(),
                            SpinCode3 = dr1[7].ToString().Trim(),
                            SpinPrize3 = dr1[8].ToString().Trim(),
                            SpinCode4 = dr1[9].ToString().Trim(),
                            SpinPrize4 = dr1[10].ToString().Trim(),
                            SpinCode5 = dr1[11].ToString().Trim(),
                            SpinPrize5 = dr1[12].ToString().Trim(),
                            SpinCode6 = dr1[13].ToString().Trim(),
                            SpinPrize6 = dr1[14].ToString().Trim(),
                            SpinCode7 = dr1[15].ToString().Trim(),
                            SpinPrize7 = dr1[16].ToString().Trim(),
                            SpinCode8 = dr1[17].ToString().Trim(),
                            SpinPrize8 = dr1[18].ToString().Trim(),
                            SpinCode9 = dr1[19].ToString().Trim(),
                            SpinPrize9 = dr1[20].ToString().Trim(),
                            SpinCode10 = dr1[21].ToString().Trim(),
                            SpinPrize10 = dr1[22].ToString().Trim(),
                            SpinCode11 = dr1[23].ToString().Trim(),
                            SpinPrize11 = dr1[24].ToString().Trim(),
                            SpinCode12 = dr1[25].ToString().Trim(),
                            SpinPrize12 = dr1[26].ToString().Trim(),
                            SpinCode13 = dr1[27].ToString().Trim(),
                            SpinPrize13 = dr1[28].ToString().Trim(),
                            SpinCode14 = dr1[29].ToString().Trim(),
                            SpinPrize14 = dr1[30].ToString().Trim(),
                            SpinCode15 = dr1[31].ToString().Trim(),
                            SpinPrize15 = dr1[32].ToString().Trim(),
                        };

                        responseBody.Prize.Add(itm);
                    }
                    //var spinCode = SlotService.PrizeGrpList(req.DrawId);
                    // Validate VipLevel


                    List<respSlotMbrDrawListMdl> groupSpinCodes123 = SlotService.MbrDrawList(DrawId, 0, 0, 0, null);
                    HashSet<string> mbrCodes = new HashSet<string>(groupSpinCodes123.Select(x => x.MbrCode));
                    //HashSet<string> mbrCodes = new HashSet<string>(groupSpinCodes123.Select(x => x.pri));

                foreach (DataRow dr1 in dtSheet1.Rows.Cast<DataRow>().Skip(1)) // Skipping header row
                    {
                        // Check if LoginName exists in MbrCode HashSet
                        if (!mbrCodes.Contains(itm.LoginName))
                        {
                            errorCode = enErrorCode.SLOT_Import_InvalidLoginName;
                            return returnResponse(errorCode, responseBody);
                        }

                        bool isValidVipLevel = int.TryParse(itm.VipLevel, out int vipLevel) && vipLevel <= 8;

                        // Validate Currency
                        bool isValidCurrency = itm.Currency == "RMB" || itm.Currency == "USDT";

                        if (!isValidVipLevel)
                        {
                            errorCode = enErrorCode.SLOT_Import_InvalidVipLevel;
                            return returnResponse(errorCode, responseBody);
                        }

                        if (!isValidCurrency)
                        {
                            errorCode = enErrorCode.SLOT_Import_InvalidCurrency;
                            return returnResponse(errorCode, responseBody);
                        }

                    }

                    //bool foundEmptySpin = false;
                    bool isValidRow = true;
                    // Assuming SlotService.PrizeGrpList returns a list of GroupSpinCode
                    List<SlotPrizeGrpListMdl> groupSpinCodes = SlotService.PrizeGrpList(DrawId);
                    Dictionary<string, int> prizeCounts = new Dictionary<string, int>();

                    // Convert to a HashSet or Dictionary for efficient lookup
                    HashSet<string> groupSpinCodeSet = new HashSet<string>(groupSpinCodes.Select(x => x.Code));
                    HashSet<string> groupSpinDisplayNameSet = new HashSet<string>(groupSpinCodes.Select(x => x.DisplayName));

                    foreach (DataRow dr1 in dtSheet1.AsEnumerable().Skip(1))
                    {
                        bool foundEmptySpin = false;
                        for (int i = 3; i <= 31; i += 2) // Adjust these indices to match your actual data columns for spins
                        {
                            string spinCode = dr1[i].ToString().Trim();
                            string spinPrize = dr1[i + 1].ToString().Trim();

                            if (!string.IsNullOrEmpty(spinCode) && !string.IsNullOrEmpty(spinPrize))
                            {
                                // Validate SpinCode and SpinPrize
                                if (!groupSpinCodeSet.Contains(spinCode))
                                {
                                    errorCode = enErrorCode.SLOT_Import_InvalidPrizeCode;
                                    return returnResponse(errorCode, responseBody);
                                }
                                if (!groupSpinDisplayNameSet.Contains(spinPrize))
                                {
                                    errorCode = enErrorCode.SLOT_Import_InvalidPrizeName;
                                    return returnResponse(errorCode, responseBody);
                                }
                            }

                            if (string.IsNullOrEmpty(spinCode) && string.IsNullOrEmpty(spinPrize))
                            {
                                // An empty spin is found
                                foundEmptySpin = true;
                            }
                            else if (foundEmptySpin)
                            {
                                // Found a non-empty spin after an empty spin, invalid row
                                isValidRow = false;
                                break;
                            }

                            #region check qty from db, see how many left over
                            //Check if the spin has valid data
                            if (!string.IsNullOrEmpty(spinCode) && !string.IsNullOrEmpty(spinPrize))
                            {
                                //string compositeKey = spinCode + "_" + spinPrize;

                                if (prizeCounts.ContainsKey(spinPrize))
                                {
                                    prizeCounts[spinPrize] += 1;
                                }
                                else
                                {
                                    prizeCounts[spinPrize] = 1;
                                }
                            }
                        }

                        foreach (var groupSpinCode in groupSpinCodes)
                        {
                            if (prizeCounts.TryGetValue(groupSpinCode.DisplayName, out int count))
                            {
                                if (count > groupSpinCode.RemainCount) // Assuming Quantity is a property in SlotPrizeGrpListMdl
                                {
                                    errorCode = enErrorCode.SLOT_Import_InvalidRemainCount;
                                    return returnResponse(errorCode, responseBody);
                                }
                            }
                        }
                        #endregion

                        if (!isValidRow)
                        {
                            errorCode = enErrorCode.SLOT_Import_InconsistentSpinDataAcrossRow;
                            return returnResponse(errorCode, responseBody);
                        }
                    }
                responseBody.IsSuccess = true;
                if (responseBody.IsSuccess == true)
                {
                    if (SlotService.Import(responseBody, userdetails.UserId))
                    {
                        responseBody.IsSuccess = true;
                    }
                    else
                    {
                        ResponseInternalServerError();
                    }
                }


                    return returnResponse(errorCode, responseBody);
                }
                catch (Exception ex)
                {
                    //responseBody.IsImportValid = false;
                    errorCode = enErrorCode.SLOT_Import_InvalidFile;
                    return returnResponse(errorCode, responseBody);
                }
        }

        [MenuAccessFilter(MenuAccessId = enMenuAccessId.Import_Reward_Member)]
        [HttpPost]
        [Route("ImportPrizeFinal")]//after submit use one
        public HttpResponseMessage ImportPrizeFinal([FromBody] reqSlotImportWiningCombinationsMdl req)
        { 
            var responseBody = new CommonActionResponse() { IsSuccess = false };

            var userdetails = UserHelper.GetCurrentUser();
            enErrorCode? errorCode = null;

            if (req == null)
            {
                errorCode = enErrorCode.Request_Invalid;
                return returnResponse(errorCode, responseBody);
            }

            if (req.IsValid == 0)
            {
                errorCode = enErrorCode.Request_Invalid;
                return returnResponse(errorCode, responseBody);
            }

            if (SlotService.ImportWinCom(req, userdetails.UserId))
            {
                responseBody.IsSuccess = true;
            }
            else
            {
                ResponseInternalServerError();
            }

            return returnResponse(errorCode, responseBody);
        }
        #endregion

        #endregion

        [MenuAccessFilter(MenuAccessId = enMenuAccessId.View_Draw)]
        [HttpGet]
        [Route("ExportMbr")]
        public HttpResponseMessage ExportMbr([FromUri] reqSlotImportMbr req)
        {
            var result = Request.CreateResponse(HttpStatusCode.OK);

            var list = SlotService.MbrDrawList(drawId: req.Id, req.VipLevel, req.Page, req.Size, req.Code);

            ExcelPackage Ep = new ExcelPackage();
            ExcelWorksheet Sheet = Ep.Workbook.Worksheets.Add("Member");

            #region Headers
            Sheet.Cells["A1"].Value = "Member Code";
            Sheet.Cells["B1"].Value = "VIP";
            Sheet.Cells["C1"].Value = "Currency";
            Sheet.Cells["D1"].Value = "Spin 1";
            Sheet.Cells["E1"].Value = "Spin 1 Prize";
            Sheet.Cells["F1"].Value = "Spin 2";
            Sheet.Cells["G1"].Value = "Spin 2 Prize";
            Sheet.Cells["H1"].Value = "Spin 3";
            Sheet.Cells["I1"].Value = "Spin 3 Prize";
            Sheet.Cells["J1"].Value = "Spin 4";
            Sheet.Cells["K1"].Value = "Spin 4 Prize";
            Sheet.Cells["L1"].Value = "Spin 5";
            Sheet.Cells["M1"].Value = "Spin 5 Prize";
            Sheet.Cells["N1"].Value = "Spin 6";
            Sheet.Cells["O1"].Value = "Spin 6 Prize";
            Sheet.Cells["P1"].Value = "Spin 7";
            Sheet.Cells["Q1"].Value = "Spin 7 Prize";
            Sheet.Cells["R1"].Value = "Spin 8";
            Sheet.Cells["S1"].Value = "Spin 8 Prize";
            Sheet.Cells["T1"].Value = "Spin 9";
            Sheet.Cells["U1"].Value = "Spin 9 Prize";
            Sheet.Cells["V1"].Value = "Spin 10";
            Sheet.Cells["W1"].Value = "Spin 10 Prize";
            Sheet.Cells["X1"].Value = "Spin 11";
            Sheet.Cells["Y1"].Value = "Spin 11 Prize";
            Sheet.Cells["Z1"].Value = "Spin 12";
            Sheet.Cells["AA1"].Value = "Spin 12 Prize";
            Sheet.Cells["AB1"].Value = "Spin 13";
            Sheet.Cells["AC1"].Value = "Spin 13 Prize";
            Sheet.Cells["AD1"].Value = "Spin 14";
            Sheet.Cells["AE1"].Value = "Spin 14 Prize";
            Sheet.Cells["AF1"].Value = "Spin 15";
            Sheet.Cells["AG1"].Value = "Spin 15 Prize";
            #endregion

            if (list.Count > 0)
            {
                #region Body
                int row = 2;
                foreach (var x in list)
                {
                    Sheet.Cells[string.Format("A{0}", row)].Value = x.MbrCode;
                    Sheet.Cells[string.Format("B{0}", row)].Value = x.VIP;
                    Sheet.Cells[string.Format("C{0}", row)].Value = x.Currency;

                    row++;
                }
                Sheet.Cells["A:AZ"].AutoFitColumns();
                #endregion
            }

            result.Content = new ByteArrayContent(Ep.GetAsByteArray());
            result.Content.Headers.ContentType = new MediaTypeHeaderValue("application/vnd.ms-excel");
            result.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment")
            {
                FileName = "ImportMember.xlsx"
            };

            return result;
        }

        #region Validation
        /*private enErrorCode? AddDrawValidation(reqSlotPrizeNewModel input)*/
        private enErrorCode? AddDrawValidation(reqAddNewDrawMdl input)
        {
            enErrorCode? errorCode = null;

            if (!input.CampaignId.HasValue)
            {
                return enErrorCode.CampaignId_Empty;
            }

            if (!input.PreStart.HasValue)
            {
                return enErrorCode.DrawPreStart_Empty;
            }

            if (!input.StartDate.HasValue)
            {
                return enErrorCode.DrawStartDate_Empty;
            }

            if (!input.EndDate.HasValue)
            {
                return enErrorCode.DrawEndDate_Empty;
            }

            if (input.PreStart >= input.StartDate || input.PreStart >= input.EndDate)
            {
                return enErrorCode.DrawPreStartRange_Error;
            }

            if (input.StartDate >= input.EndDate)
            {
                return enErrorCode.DrawDateRange_Error;
            }

            /*if (input.Views.Count == 0)
            {
                return enErrorCode.SPW_View_Empty;
            }*/

            if (!PromotionService.DrawDateValidation(input.CampaignId, input.PreStart, input.StartDate, input.EndDate))
            {
                return enErrorCode.DrawDateTimeNotMatchPromotionDateTime_Error;
            }

            if (!PromotionService.DrawOverlapValidation(null, input.CampaignId, input.PreStart, input.StartDate, input.EndDate))
            {
                return enErrorCode.DrawDateTimeOverlap_Error;
            }

            return errorCode;
        }

        private enErrorCode? drawStatusValidation(long drawId)
        {
            enErrorCode? errorCode = null;

            if (!PromotionService.CheckDrawStatus(drawId))
            {
                errorCode = enErrorCode.DrawClearBlockedDueToStatus_Error;
            }

            return errorCode;
        }

        private enErrorCode? drawStatusValidationForImportRandDraw(long drawId)
        {
            enErrorCode? errorCode = null;

            if (!SlotService.CheckDrawStatusForImportRandDraw(drawId))
            {
                errorCode = enErrorCode.DrawClearBlockedDueToStatus_Error;
            }

            return errorCode;
        }
        #endregion

        #region Util
        private static string GetUniNo()
        {
            Guid guid = Guid.NewGuid();
            string base36 = Convert.ToBase64String(guid.ToByteArray())
                              .Replace("/", "")
                              .Replace("+", "");
            var uni = base36.Substring(0, 6).ToUpper().ToCharArray();
            var result = DateTime.UtcNow.ToString($"yy{uni[0]}yy{uni[1]}MM{uni[2]}dd{uni[3]}HH{4}mm");
            return result;
        }
        #endregion
    }
}