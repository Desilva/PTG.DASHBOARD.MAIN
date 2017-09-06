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

function addAccount(data) {
    var url = "";

    kendo.ui.progress($("#formWindow"), true);
    url = urlAction("DataMaster", "PLAccount", "Create");
    $(".k-window").css("margin-top", "-140px");
    $(".k-window").css("margin-left", "-10px");
    $("#formWindow").load(url, function (response, status, xhr) {
        setStyleFormWindow();
        setValidator();
        setFormPLAccount();
        kendo.ui.progress($("#formWindow"), false);
        $("html, body").css("overflow", "hidden");
        setTimeout(function () {
            $("#AccountName").focus();
        }, 500);
        var category = $("#formWindow").find("#AccountCategory");
        setCategoriesList(category, data, "");

        var order = $("#formWindow").find("#OrderNum");
        firstLoadOrder(order, category.val(), "");
    });

    formDialog.title("Tambah Akun");
    formDialog.center();
    formDialog.open();
}

function editAccount(id) {
    var url = "";

    kendo.ui.progress($("#formWindow"), true);
    url = urlAction("DataMaster", "PLAccount", "Edit") + "?id=" + id;
    $(".k-window").css("margin-top", "-140px");
    $(".k-window").css("margin-left", "-10px");
    $("#formWindow").load(url, function (response, status, xhr) {
        setStyleFormWindow();
        setValidator();
        setFormPLAccount();
        kendo.ui.progress($("#formWindow"), false);
        $("html, body").css("overflow", "hidden");
        setTimeout(function () {
            $("#AccountName").focus();
        }, 500);
        var name = $("#formWindow").find("#AccountName");
        var oldValue = $(response).find("#AccountCategory").val();
        var category = $("#formWindow").find("#AccountCategory");
        var order = $("#formWindow").find("#OrderNum");
        $.ajax({
            url: urlAction("DataMaster", "PLAccount", "CategoriesOptionsAsync"),
            success: function (data) {
                firstLoadOrder(order, oldValue, name.val());
                setCategoriesList(category, JSON.parse(data), name.val());
            },
        });

        var el = $("#formWindow").find("#OrderNum");
    });

    formDialog.title("Ubah Akun");
    formDialog.center();
    formDialog.open();
}

function deleteAccount(id, name) {
    var ds = $("#grid").getKendoGrid().dataSource;
    swal({
        title: "Konfirmasi",
        text: "Apakah anda yakin menghapus data ini " + name + " ?",
        type: "warning",
        showCancelButton: true,
        //confirmButtonColor: "#DD6B55",
        confirmButtonText: "Ya",
        closeOnConfirm: false
    },
        function () {
            $.ajax({
                url: urlAction("DataMaster", "PLAccount", "Delete"),
                type: "POST",
                data: { "id": id },
                success: function (data) {
                    if (data.Success) {
                        swal("Sukses", data.Message, "success");
                        submitFlag = true;
                        formDialog.close();
                        ds.read();
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    swal("Error", "Server Error. Harap hubungi administrator", "error");
                }
            });
            $(".sweet-alert").css("z-index", "999999");
        });
    $(".sweet-alert").css("z-index", "999999");
    return false;
}

function closeWindow() {
    formDialog.close();
}

function firstLoadOrder(el, category, name) {
    url = urlAction("DataMaster", "PLAccount", "GetOrderNumAsync");
    $.ajax({
        url: url,
        type: "GET",
        data: {
            "category": category,
            "name": name
        },
        success: function (data) {
            var numerictextbox = $(el).data("kendoNumericTextBox");
            $(el).kendoNumericTextBox({
                format: "n0",
                min: data,
                max: 100000,
                step: 1,
                value: data
            });
        },
    });
}

function getOrderNum(el, category, name) {
    url = urlAction("DataMaster", "PLAccount", "GetOrderNumAsync");
    $.ajax({
        url: url,
        type: "GET",
        data: {
            "category": category,
            "name": name
        },
        success: function (data) {
            var numerictextbox = $(el).data("kendoNumericTextBox");
            var min = numerictextbox.min();
            var value = numerictextbox.value();
            numerictextbox.min(data);
            numerictextbox.value(data);
        },
    });
}

function getAccountDataSource() {
    var result = new kendo.data.DataSource({
        pageable: false,
        serverFiltering: false,
        serverPaging: false,
        serverSorting: false,
        transport: {
            read: {
                url: urlAction("DataMaster", "PLAccount", "Binding"),
                dataType: "json",
                type: "POST"
            },
            parameterMap: function (options, operation) {
                if (operation !== "read" && options !== "") {
                    return kendo.stringify(options);
                }
                return options;
            }
        },
        group: {
            field: "AccountCategoryDesc",
            dir: "asc"
        },
        sort: { field: "OrderNum", dir: "asc" },
        schema: {
            data: "data",
            total: "total",
            model: {
                id: "PLAccountId",
                fields: {
                    "PLAccountId": { type: "number" },
                }
            }
        }
    });

    return result;
}

function setStyleFormWindow() {
    $(".k-window").removeClass("k-widget");
    $(".k-window-titlebar").css("height", "36px");
    $(".k-window-actions").find("a").css("height", "20px");
    $(".k-window-actions").find("a").css("width", "20px");
}

function setValidator() {
    $.validator.unobtrusive.parse("#accountForm");
    $("#accountForm").data("validator").settings.ignore = ":hidden:not(.validateAlways)";

    $("input").on("keyup blur", function () {
        if ($("#accountForm").valid()) {
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
                    $("#accountForm").submit();
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

function setCategoriesList(el, data, name) {
    var temp = "";
    var oldCat = $(el).val();
    $(el).kendoDropDownList({
        dataTextField: "Text",
        dataValueField: "Value",
        dataSource: data,
        height: 100,
        change: function (e) {
            var orderNum = $("#formWindow").find("#OrderNum");
            if (oldCat == this.value())
                temp = name;
            getOrderNum(orderNum, this.value(), temp);
        }
    }).closest(".k-widget")
}

function setFormPLAccount() {
    var ds = $("#grid").getKendoGrid().dataSource;

    $("#accountForm").submit(function (e) {
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
                        swal("Sukses", data.Message, "success");
                        submitFlag = true;
                        formDialog.close();
                        ds.read();
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

function setGrid() {
    $("#grid").kendoGrid({
        dataSource: getAccountDataSource(),
        //dataBound: kendoGridAutoScrollY,
        //filterable: kendoGridFilterable,
        pageable: false,
        sortable: false,
        resizable: true,
        scrollable: true,
        columns: [
            {
                field: "OrderNum",
                title: " ",
                width: "40px"
                //template: kendo.template($("#nameTemplate").html())
            },
            {
                field: "AccountName",
                title: "Akun",
                //template: kendo.template($("#dateTemplate").html()),
                //width: "150px"
            },
            {
                field: "AccountCategoryDesc",
                title: "",
                groupHeaderTemplate: "#= value.substring(1) #",
                hidden: true
            },
            {
                field: "coms",
                title: " ",
                filterable: false,
                sortable: false,
                template: kendo.template($("#commandTemplate").html()),
                width: "110px"
            },
        ]
    });
}