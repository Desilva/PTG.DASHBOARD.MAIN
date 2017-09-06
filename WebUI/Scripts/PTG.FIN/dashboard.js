//reload when dropdown change
$("#Year").change(function () {
    $("#formDashboard").submit()
})

function submit() {
    var optValue = $('input[name=radio_target]:checked').val();
    if (optValue == 125) {
        $.post("/SessionMenuHelper/Cookies", { option: "125" }, function () {
            window.location.reload();
        })
    } else {
        $.post("/SessionMenuHelper/Cookies", { option: "150" }, function () {
            window.location.reload();
        })
    }
}

function createChart(bindingUrlNetProfit,
    bindingUrlSalesGrowth, bindingUrlEbitda,
    bindingUrlEbitdaMargin,
    bindingUrlSalesToAverageAsset,
    bindingUrlAverageAssetToAverageEquity,
    bindingUrlInvestment) {

    $("#chart-net-profit").kendoChart({
        dataSource: {
            transport: {
                read: {
                    url: bindingUrlNetProfit,
                    dataType: "json"
                }
            }
        },
        chartArea: {
            height: 275
        },
        legend: {
            position: "bottom"
        },
        series: [{
            type: "column",
            field: "Actual",
            stack: true,
            name: "realisasi",
            color: "#32599c",
            //labels: {
            //    template: "#= kendo.toString(value, \"n\") #",
            //    visible: true,
            //    rotation: -45
            //}
        }, {
            type: "line",
            field: "RKAPBase",
            name: "base",
            color: "#da251c"
        }, {
            type: "line",
            field: "RKAPStretch",
            name: "stretch",
            color: "#85c226"
        }],
        valueAxis: {
            labels: {
                format: "N0"
            }
        },
        categoryAxis: {
            field: "MonthDesc",
            labels: {
                rotation: -45
            }
        },
        tooltip: {
            background: "#FFFFFF",
            visible: true,
            format: "N0"
        }
    });

    $("#chart-sales-growth").kendoChart({
        dataSource: {
            transport: {
                read: {
                    url: bindingUrlSalesGrowth,
                    dataType: "json"
                }
            }
        },
        chartArea: {
            height: 275
        },
        legend: {
            position: "bottom"
        },
        series: [{
            type: "column",
            field: "Actual",
            stack: true,
            name: "realisasi",
            color: "#32599c",
        }, {
            type: "line",
            field: "RKAPBase",
            name: "base",
            color: "#da251c"
        }, {
            type: "line",
            field: "RKAPStretch",
            name: "stretch",
            color: "#85c226"
        }],
        valueAxis: {
            labels: {
                format: "N0"
            }
        },
        categoryAxis: {
            field: "MonthDesc",
            labels: {
                rotation: -45
            }
        },
        tooltip: {
            background: "#FFFFFF",
            visible: true,
            format: "N2"
        }
    });

    $("#chart-ebitda").kendoChart({
        dataSource: {
            transport: {
                read: {
                    url: bindingUrlEbitda,
                    dataType: "json"
                }
            }
        },
        chartArea: {
            height: 275
        },
        legend: {
            position: "bottom"
        },
        series: [{
            type: "column",
            field: "Actual",
            stack: true,
            name: "realisasi",
            color: "#32599c",
        }, {
            type: "line",
            field: "RKAPBase",
            name: "base",
            color: "#da251c"
        }, {
            type: "line",
            field: "RKAPStretch",
            name: "stretch",
            color: "#85c226"
        }],
        valueAxis: {
            labels: {
                format: "N0"
            }
        },
        categoryAxis: {
            field: "MonthDesc",
            labels: {
                rotation: -45
            }
        },
        tooltip: {
            background: "#FFFFFF",
            visible: true,
            format: "N2"
        }
    });

    $("#chart-ebitda-margin").kendoChart({
        dataSource: {
            transport: {
                read: {
                    url: bindingUrlEbitdaMargin,
                    dataType: "json"
                }
            }
        },
        chartArea: {
            height: 275
        },
        legend: {
            position: "bottom"
        },
        series: [{
            type: "column",
            field: "Actual",
            stack: true,
            name: "realisasi",
            color: "#32599c",
        }, {
            type: "line",
            field: "RKAPBase",
            name: "base",
            color: "#da251c"
        }, {
            type: "line",
            field: "RKAPStretch",
            name: "stretch",
            color: "#85c226"
        }],
        valueAxis: {
            labels: {
                format: "N0"
            }
        },
        categoryAxis: {
            field: "MonthDesc",
            labels: {
                rotation: -45
            }
        },
        tooltip: {
            background: "#FFFFFF",
            visible: true,
            format: "N2"
        }
    });

    $("#chart-sales-to-average-asset").kendoChart({
        dataSource: {
            transport: {
                read: {
                    url: bindingUrlSalesToAverageAsset,
                    dataType: "json"
                }
            }
        },
        chartArea: {
            height: 275
        },
        legend: {
            position: "bottom"
        },
        series: [{
            type: "column",
            field: "Actual",
            stack: true,
            name: "realisasi",
            color: "#32599c",
        }, {
            type: "line",
            field: "RKAPBase",
            name: "base",
            color: "#da251c"
        }, {
            type: "line",
            field: "RKAPStretch",
            name: "stretch",
            color: "#85c226"
        }],
        valueAxis: {
            labels: {
                format: "N0"
            }
        },
        categoryAxis: {
            field: "MonthDesc",
            labels: {
                rotation: -45
            }
        },
        tooltip: {
            background: "#FFFFFF",
            visible: true,
            format: "N2"
        }
    });

    $("#chart-average-asset-to-average-equity").kendoChart({
        dataSource: {
            transport: {
                read: {
                    url: bindingUrlAverageAssetToAverageEquity,
                    dataType: "json"
                }
            }
        },
        chartArea: {
            height: 275
        },
        legend: {
            position: "bottom"
        },
        series: [{
            type: "column",
            field: "Actual",
            stack: true,
            name: "realisasi",
            color: "#32599c",
        }, {
            type: "line",
            field: "RKAPBase",
            name: "base",
            color: "#da251c"
        }, {
            type: "line",
            field: "RKAPStretch",
            name: "stretch",
            color: "#85c226"
        }],
        valueAxis: {
            labels: {
                format: "N0"
            }
        },
        categoryAxis: {
            field: "MonthDesc",
            labels: {
                rotation: -45
            }
        },
        tooltip: {
            background: "#FFFFFF",
            visible: true,
            format: "N2"
        }
    });

    $("#chart-investment").kendoChart({
        dataSource: {
            transport: {
                read: {
                    url: bindingUrlInvestment,
                    dataType: "json"
                }
            }
        },
        chartArea: {
            height: 275
        },
        legend: {
            position: "bottom"
        },
        series: [{
            type: "column",
            field: "Actual",
            stack: true,
            name: "realisasi",
            color: "#32599c",
        }, {
            type: "line",
            field: "RKAPBase",
            name: "base",
            color: "#da251c"
        }, {
            type: "line",
            field: "RKAPStretch",
            name: "stretch",
            color: "#85c226"
        }],
        valueAxis: {
            labels: {
                format: "N0"
            }
        },
        categoryAxis: {
            field: "MonthDesc",
            labels: {
                rotation: -45
            }
        },
        tooltip: {
            background: "#FFFFFF",
            visible: true,
            format: "N2"
        }
    });
}

function changeTooltipText() {
    //kamus
    var companyId = $('[name="CompanyId"]:checked').val();
    var tooltipTxtArray = [];
    var tooltipRevenue = $('#panel-revenue [data-toggle="tooltip"]');
    var tooltipSalesGrowth = $('#panel-sales-growth [data-toggle="tooltip"]');
    var tooltipNetProfit = $('#panel-net-profit [data-toggle="tooltip"]');
    var tooltipEbitda = $('#panel-ebitda [data-toggle="tooltip"]');
    var tooltipEbitdaMargin = $('#panel-ebitda-margin [data-toggle="tooltip"]');
    var tooltipSalesToAverageAsset = $('#panel-sales-to-average-asset [data-toggle="tooltip"]');
    var tooltipAverageAssetToAverageEquity = $('#panel-average-asset-to-average-equity [data-toggle="tooltip"]');
    var tooltipInvestasi = $('#panel-investasi [data-toggle="tooltip"]');

    //algoritma
    tooltipTxtArray = {
        revenue: '- Merupakan jumlah pendapatan Pertagas (PTG) yang terdiri dari pendapatan niaga gas, transportasi gas, transportasi minyak, proses gas (regasifikasi) dan marketing fee dari penyaluran gas pipa.<br>- Laba Bersih PDG dan PSG sesuai porsi/share Pertagas akan ditambahkan pada perhitungan Laba Bersih Pertagas.',
        salesGrowth: '- Merupakan jumlah pertumbuhan pendapatan usaha Pertagas (PTG).<br>- Formula perhitungan:<br>Pertumbuhan Pendapatan Usaha = Pendapatan bulan berjalan tahun ini / Pendapatan bulan berjalan tahun lalu',
        netProfit: '- Merupakan jumlah laba bersih Pertagas (PTG).<br>- Formula perhitungan:<br>Laba Bersih = Laba Usaha + Pendapatan (Beban) Lain - Pajak',
        ebitda: '- Merupakan jumlah EBITDA konsolidasi dari EBITDA  Pertagas.<br>- EBITDA adalah laba sebelum bunga, pajak, depresiasi dan amortisasi.',
        ebitdaMargin: 'Formula perhitungan:<br>EBITDA Margin = EBITDA Konsolidasi Pertagas/Pendapatan Usaha Konsolidasi Pertagas',
        salesToAverageAsset: 'Formula perhitungan:<br />Sales to Average Asset = Total Pendapatan Usaha / Average Asset',
        averageAssetToAverageEquity: 'Formula perhitungan:<br />Average Asset to Average Equity = Average Asset / Average Equity',
        investasi: ''
    };

    tooltipRevenue.prop('title', tooltipTxtArray.revenue).tooltip('fixTitle');
    tooltipSalesGrowth.prop('title', tooltipTxtArray.salesGrowth).tooltip('fixTitle');
    tooltipNetProfit.prop('title', tooltipTxtArray.netProfit).tooltip('fixTitle');
    tooltipEbitda.prop('title', tooltipTxtArray.ebitda).tooltip('fixTitle');
    tooltipEbitdaMargin.prop('title', tooltipTxtArray.ebitdaMargin).tooltip('fixTitle');
    tooltipSalesToAverageAsset.prop('title', tooltipTxtArray.salesToAverageAsset).tooltip('fixTitle');
    tooltipAverageAssetToAverageEquity.prop('title', tooltipTxtArray.averageAssetToAverageEquity).tooltip('fixTitle');
    tooltipInvestasi.prop('title', tooltipTxtArray.investasi).tooltip('fixTitle');
}