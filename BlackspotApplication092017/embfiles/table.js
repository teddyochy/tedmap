function mv_showTableInFP(b,c){var d=!0,e=mv_getMediaScreen();"smartphone"==e&&(d=!1);mv_loadAttrTableFile(b,!0);if(0!=mv_XMLFileArray[b].count()){var a=null==c?"Attribute von "+mv_XMLFileArray[b].Name:"Attribute von "+c;mv_closeTable(a);var f=mv_makeNode(document,"div",{id:"MVtableFP","class":"tableFP"});f.style.display="none";dojo.body().appendChild(f);var h=dojo.byId("MVtableContent");mv_removeEle(h);h=mv_makeNode(document,"div",{id:"MVtableContent"});f.appendChild(h);mv_sortTable(b);require(["dojox/layout/FloatingPane"],
function(b){b=new b({resizable:!1,dockable:!1,closable:d,"class":"tableFP",title:a,style:"position:absolute;top:30px;left:60px;width:auto;height:auto;visibility:hidden;padding-bottom:10px;z-index:4;"},"MVtableFP");b.startup();b.bringToTop();b.show();"smartphone"==e?b.maximize():b.set("style","width:auto;height:auto")})}}function mv_closeTable(b){var c=dijit.byId("MVtableFP");"undefined"!=typeof c&&c.title!=b&&c.destroy()}
function mv_sortTable(b,c,d,e){document.getElementById("MVtableContent").innerHTML="Bitte warten ...";try{var a=new XSLTProcessor,f=mv_loadXMLDoc(mv_Doc.BaseURL+"/embfiles/styletable.xsl","xml");try{a.importStylesheet(f)}catch(h){f=document.implementation.createDocument("","",null),f.async=!1,f.load("embfiles/styletable.xsl"),a.importStylesheet(f)}a.setParameter(null,"lid",b);a.setParameter(null,"lang",mv_Doc.Language);c&&(a.setParameter(null,"field","f"+(parseInt(c)-1)),a.setParameter(null,"datatype",
d),a.setParameter(null,"orderby",e));var l=a.transformToFragment(mv_XMLFileArray[b].XMLFile,document);document.getElementById("MVtableContent").innerHTML="";document.getElementById("MVtableContent").appendChild(l)}catch(m){try{var k=new ActiveXObject("Msxml2.XSLTemplate.4.0"),g=new ActiveXObject("Msxml2.FreeThreadedDOMDocument.4.0")}catch(n){k=new ActiveXObject("Msxml2.XSLTemplate"),g=new ActiveXObject("Msxml2.FreeThreadedDOMDocument")}g.async=!1;g.resolveExternals=!1;g.load("embfiles/styletable.xsl");
k.stylesheet=g;a=k.createProcessor();a.input=mv_XMLFileArray[b].XMLFile;a.addParameter("lid",b);a.addParameter("lang",mv_Doc.Language);c&&(a.addParameter("field","f"+(parseInt(c)-1)),a.addParameter("datatype",d),a.addParameter("orderby",e));a.transform();document.getElementById("MVtableContent").innerHTML=a.output}}
function mv_tableToExcel(b,c){"string"==typeof b&&(b=document.getElementById(b));for(var d=b.cloneNode(!0),e=d.getElementsByTagName("td"),a=-1;++a<e.length;)0==isNaN(parseFloat(e[a].textContent))&&(e[a].textContent=e[a].textContent.replace(",","."));d={worksheet:c||"Worksheet",table:d.innerHTML};e=function(a){return window.btoa(unescape(encodeURIComponent(a)))};a=function(a,b){return a.replace(/{(\w+)}/g,function(a,c){return b[c]})};window.navigator.msSaveOrOpenBlob?(d=["\ufeffdata:application/vnd.ms-excel;base64,"+
a('<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head>\x3c!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><style type="text/css">table {mso-displayed-decimal-separator:".";mso-displayed-thousand-separator:",";}</style><![endif]--\x3e</head><body><table>{table}</table></body></html>',
d)],blobObject=new Blob(d),window.navigator.msSaveOrOpenBlob(blobObject,c+".xls")):window.location.href="data:application/vnd.ms-excel;base64,"+e(a('<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head>\x3c!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><style type="text/css">table {mso-displayed-decimal-separator:".";mso-displayed-thousand-separator:",";}</style><![endif]--\x3e</head><body><table>{table}</table></body></html>',
d))};