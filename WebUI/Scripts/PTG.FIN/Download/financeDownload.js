$(function () {
    var modulType = $("#ModulType").val();
    var year = $("#Year").val();
    bindModul();
    bindYear();
    bindVersion(year);
    setVersion(modulType);

    $("#Year").change(function () {
        year = $(this).val();
        bindVersion(year);
    });

    $("#ModulType").change(function () {
        modulType = $(this).val();
        if(modulType=='PROGNOSA')
            bindVersion(year);
        setVersion(modulType);
    });
});

function bindModul() {
    $("#ModulType").kendoDropDownList({
        dataTextField: "Text",
        dataValueField: "Value",
        dataSource: {
            transport: {
                read: {
                    url: urlAction("DownloadExcel", "Finance", "BindModulTypes"),                    
                    dataType: "json",
                },
            },
            schema: {
                data: "data",
            },
        }
    });
}

function bindYear() {
    $("#Year").kendoDropDownList({
        dataTextField: "Text",
        dataValueField: "Value",
        dataSource: {
            transport: {
                read: {
                    url: urlAction("DownloadExcel", "Finance", "BindYears"),                                        
                    dataType: "json",
                },
            },
            schema: {
                data: "data",
            },
        }
    });
}

function bindVersion(year) {
    $("#VersionId").kendoDropDownList({
        dataTextField: "Version",
        dataValueField: "PrognosisVersionId",
        dataSource: {
            transport: {
                read: {
                    url: urlAction("DownloadExcel", "Finance", "BindVersions") + '?year=' + year,                                        
                    dataType: "json",
                },
            },
            schema: {
                data: "data",
            },
        }
    });
}

function setVersion(type) {
    if (type == 'PROGNOSA') {
        $("#IsPrognosis").val(true);
        $("#versionOptions").css("display", "block");
    }
    else {
        $("#IsPrognosis").val(false);
        $("#versionOptions").css("display", "none");
    }
}