$("#Year").change(function () {
    $("#form").submit()
})

var formDialog = $("#formWindow").kendoWindow({
    width: "400px",
    visible: false,
    resizable: false,
    modal: true,
    actions: [
        "Close"
    ],
    close: function (e) {
        $("#formWindow").html("");
        $("html, body").css("overflow", "");
    }
}).data("kendoWindow");

var inputFileSelector = "#FileExcel";

//FILE RELATED
function onRemove(e) {
    $(inputFileSelector).val("");
}

function onSelectFile(e) {
    var flagExtension = 0;
    var flagSize = 0;
    var allowedExtension;
    var file = e.files;
    allowedExtension = ['.xlsx'];
    if (file[0].size > 1048576) {
        flagSize = 1;
    }

    if ($.inArray((file[0].extension).toLowerCase(), allowedExtension) === -1) {
        flagExtension = 1;
    }

    if (flagExtension == 1) {
        alert("Jenis berkas harus .xlsx");
        e.preventDefault();
    }

    if (flagSize == 1) {
        alert("Ukuran Maksimal");
        e.preventDefault();
    }
}

function onSuccessFile(e) {
    var filepath = e.response.filepath;
    $(inputFileSelector).val(filepath);
    if (e.operation == "upload") {
        var file = e.response;
        $('#FileExcel').val(file.filepath);        
        $("#Id").val($("#Version").val());        
        var ext = e.files[0].extension;

    }
}

function addPrognosis(months, is150) {
    var url = "";
    kendo.ui.progress($("#formWindow"), true);
    if (is150) {
        url = urlAction("UpdateData", "Prognosis150", "Create");
    } else {
        url = urlAction("UpdateData", "Prognosis", "Create");
    }
    $(".k-window").css("margin-top", "-140px");
    $(".k-window").css("margin-left", "-10px");
    $("#formWindow").load(url, function (response, status, xhr) {
        setStyleFormWindow();
        setValidator();
        setForm();
        kendo.ui.progress($("#formWindow"), false);
        $("html, body").css("overflow", "hidden");
        setTimeout(function () {
            $("#Version").focus();
        }, 500);
        var month = $("#formWindow").find("#Month");
        setMonth(month, months, "");

        $('#YearPrognosis').val($('#Year').val());
        $('#YearPrognosisPlaceholder').html($('#YearPrognosis').val())

        //var order = $("#formWindow").find("#OrderNum");
        //firstLoadOrder(order, category.val(), "");
    });

    formDialog.title("Tambah Prognosa");
    formDialog.center();
    formDialog.open();
}

function editPrognosis(months, year, is150) {
    var url = "";

    kendo.ui.progress($("#formWindow"), true);
    if (is150) {
        url = urlAction("UpdateData", "Prognosis150", "Edit?year=" + year);
    } else {
        url = urlAction("UpdateData", "Prognosis", "Edit?year=" + year);
    }

    $(".k-window").css("margin-top", "-140px");
    $(".k-window").css("margin-left", "-10px");
    $("#formWindow").load(url, function (response, status, xhr) {
        setStyleFormWindow();
        setValidator();
        setForm();
        kendo.ui.progress($("#formWindow"), false);
        $("html, body").css("overflow", "hidden");
        setTimeout(function () {
            $("#Version").focus();
        }, 500);
        var month = $("#formWindow").find("#Month");
        setMonth(month, months, "");

        $('#YearPrognosisPlaceholder').html($('#YearPrognosis').val())
    });

    formDialog.title("Ubah Prognosa");
    formDialog.center();
    formDialog.open();
}

function upload() {
    var url = "";
    kendo.ui.progress($("#formWindow"), true);
    url = urlAction("UpdateData", "Prognosis", "Upload");
    var doc = document.documentElement;    
    var top = (window.pageYOffset || doc.scrollTop) - (doc.clientTop || 0);
    pos = -140 - top;

    $(".k-window").css("margin-top", pos);
    $(".k-window").css("margin-left", "-10px");
    $("#formWindow").load(url, function (response, status, xhr) {
        $("#KendoUploader").kendoUpload({
            multiple: false,
            async: {
                saveUrl: urlAction("", "FileManagement", "Save"),
                removeUrl: urlAction("", "FileManagement", "Remove"),
                autoUpload: true
            },
            multiple: false,
            select: onSelectFile,
            success: onSuccessFile,
            remove: onRemove,
            showFileList: true,
        });
        setStyleFormWindow();
        setValidator();
        setFormUpload();
        kendo.ui.progress($("#formWindow"), false);
        $("html, body").css("overflow", "hidden");
        setTimeout(function () {
            $("#FileExcel").focus();
        }, 500);
    });

    formDialog.title("Upload Excel");
    formDialog.center();
    formDialog.open();
}

function upload150() {
    var url = "";
    kendo.ui.progress($("#formWindow"), true);
    url = urlAction("UpdateData", "Prognosis150", "Upload");
    var doc = document.documentElement;
    var top = (window.pageYOffset || doc.scrollTop) - (doc.clientTop || 0);
    pos = -140 - top;

    $(".k-window").css("margin-top", pos);
    $(".k-window").css("margin-left", "-10px");
    $("#formWindow").load(url, function (response, status, xhr) {
        $("#KendoUploader").kendoUpload({
            multiple: false,
            async: {
                saveUrl: urlAction("", "FileManagement", "Save"),
                removeUrl: urlAction("", "FileManagement", "Remove"),
                autoUpload: true
            },
            multiple: false,
            select: onSelectFile,
            success: onSuccessFile,
            remove: onRemove,
            showFileList: true,
        });
        setStyleFormWindow();
        setValidator150();
        setFormUpload150();
        kendo.ui.progress($("#formWindow"), false);
        $("html, body").css("overflow", "hidden");
        setTimeout(function () {
            $("#FileExcel").focus();
        }, 500);
    });

    formDialog.title("Upload Excel");
    formDialog.center();
    formDialog.open();
}

function download() {
    var url = urlAction("UpdateData", "Prognosis", "Download");
    var versionId = $("#Version").val();
    window.location.href = url + "?VersionId=" + versionId;
}

function download150() {
    var url = urlAction("UpdateData", "Prognosis150", "Download");
    var versionId = $("#Version").val();
    window.location.href = url + "?VersionId=" + versionId;
}

function closeWindow() {
    formDialog.close();
}

function setStyleFormWindow() {
    $(".k-window").removeClass("k-widget");
    $(".k-window-titlebar").css("height", "36px");
    $(".k-window-actions").find("a").css("height", "20px");
    $(".k-window-actions").find("a").css("width", "20px");
}

function setValidator() {
    $.validator.unobtrusive.parse("#prognosisForm");
    $("#prognosisForm").data("validator").settings.ignore = ":hidden:not(.validateAlways)";

    $("input").on("keyup blur", function () {
        if ($("#prognosisForm").valid()) {
            $("button[type=submit]").prop("disabled", false);
        } else {
            $("button[type=submit]").prop("disabled", "disabled");
        }

        setTimeout(function () {
            if ($("input").hasClass("input-validation-error")) {
                $("button[type=submit]").prop("disabled", "disabled");
            }
        }, 100);
    });

    $("input[type=text], input[type=hidden]").each(function () {
        var req = $(this).attr("data-val-required");
        if (undefined !== req) {
            var label = $(this).parentsUntil("form").find("label[for='" + $(this).attr("id") + "']");
            var text = label.text();
            if (text.length > 0) {
                label.append("<span style='color:red'> *</span>");
            }
        }
    });

    $("#formWindow, input[type=text]").keypress(function (e) {
        if (e !== undefined) {
            var keycode = e.keyCode || e.which;

            switch (keycode) {
                case 13:
                    e.preventDefault();
                    $("#prognosisForm").submit();
                    return false;
                case 27:
                    e.preventDefault();
                    closeWindow();
                    return false;
                default:
                    return true;
            }
        }
    });
}

function setValidator150() {
    $.validator.unobtrusive.parse("#prognosis150Form");
    $("#prognosis150Form").data("validator").settings.ignore = ":hidden:not(.validateAlways)";

    $("input").on("keyup blur", function () {
        if ($("#prognosis150Form").valid()) {
            $("button[type=submit]").prop("disabled", false);
        } else {
            $("button[type=submit]").prop("disabled", "disabled");
        }

        setTimeout(function () {
            if ($("input").hasClass("input-validation-error")) {
                $("button[type=submit]").prop("disabled", "disabled");
            }
        }, 100);
    });

    $("input[type=text], input[type=hidden]").each(function () {
        var req = $(this).attr("data-val-required");
        if (undefined !== req) {
            var label = $(this).parentsUntil("form").find("label[for='" + $(this).attr("id") + "']");
            var text = label.text();
            if (text.length > 0) {
                label.append("<span style='color:red'> *</span>");
            }
        }
    });

    $("#formWindow, input[type=text]").keypress(function (e) {
        if (e !== undefined) {
            var keycode = e.keyCode || e.which;

            switch (keycode) {
                case 13:
                    e.preventDefault();
                    $("#prognosis150Form").submit();
                    return false;
                case 27:
                    e.preventDefault();
                    closeWindow();
                    return false;
                default:
                    return true;
            }
        }
    });
}

function setMonth(el, data, name) {
    var temp = "";
    var oldCat = $(el).val();
    $(el).kendoDropDownList({
        dataTextField: "Text",
        dataValueField: "Value",
        dataSource: data,
        height: 100,
    }).closest(".k-widget")
}

function setFormUpload() {
    $("#prognosisForm").submit(function (e) {
        if ($("input").hasClass("input-validation-error")) {
            e.preventDefault();
            return false;
        } else {
            $.ajax({
                type: $(this).attr("method"),
                url: $(this).attr("action"),
                data: $(this).serialize(),
                success: function (data) {
                    if (data.Success) {
                        //swal({
                        //    title: 'Sukses',
                        //    text: data.Message,
                        //    type: 'success'
                        //}, function () {
                        //    location.reload();
                        //});
                        submitFlag = true;
                        window.location.reload();                        
                        formDialog.close();
                        //ds.read();

                    }
                    else {
                        swal("Error", data.Message, "error");
                        submitFlag = true;
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    formDialog.close();
                    swal("Error", "Server Error. Harap hubungi administrator", "error");
                }
            });
            $(".sweet-alert").css("z-index", "999999");
            e.preventDefault();
            return false;
        }
    });
}

function setFormUpload150() {
    $("#prognosis150Form").submit(function (e) {
        if ($("input").hasClass("input-validation-error")) {
            e.preventDefault();
            return false;
        } else {
            $.ajax({
                type: $(this).attr("method"),
                url: $(this).attr("action"),
                data: $(this).serialize(),
                success: function (data) {
                    if (data.Success) {
                        //swal({
                        //    title: 'Sukses',
                        //    text: data.Message,
                        //    type: 'success'
                        //}, function () {
                        //    location.reload();
                        //});
                        submitFlag = true;
                        window.location.reload();
                        formDialog.close();
                        //ds.read();

                    }
                    else {
                        swal("Error", data.Message, "error");
                        submitFlag = true;
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    formDialog.close();
                    swal("Error", "Server Error. Harap hubungi administrator", "error");
                }
            });
            $(".sweet-alert").css("z-index", "999999");
            e.preventDefault();
            return false;
        }
    });
}

function setForm() {
    $("#prognosisForm").submit(function (e) {
        if ($("input").hasClass("input-validation-error")) {
            e.preventDefault();
            return false;
        } else {
            $.ajax({
                type: $(this).attr("method"),
                url: $(this).attr("action"),
                data: $(this).serialize(),
                success: function (data) {
                    if (data.Success) {
                        swal({
                            title: 'Sukses',
                            text: data.Message,
                            type: 'success'
                        }, function () {
                            location.reload();
                        });
                        submitFlag = true;
                        //window.location.reload();
                        formDialog.close();
                        //ds.read();

                    }
                    else {
                        swal("Error", data.Message, "error");
                        submitFlag = true;
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    formDialog.close();
                    swal("Error", "Server Error. Harap hubungi administrator", "error");
                }
            });
            $(".sweet-alert").css("z-index", "999999");
            e.preventDefault();
            return false;
        }
    });
}

function getAccountDataSource(data) {
    var result = new kendo.data.DataSource({
        pageable: false,
        serverFiltering: false,
        serverPaging: false,
        serverSorting: false,
        data: data,
        group: {
            field: "AccountCategoryDesc",
            dir: "asc"
        },
        sort: { field: "OrderNum", dir: "asc" },
    });

    return result;
}