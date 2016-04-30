var padding = $('<div class="filter inactive sort-disabled panel panel-default"></div>');
var jsp = null;
var filter_types = new WebSocket("ws://" + window.location.hostname + ":8888/filters/");
var topics = new WebSocket("ws://" + window.location.hostname + ":8888/topics/");
var master = new WebSocket("ws://" + window.location.hostname + ":8888/master/");
var input_feeds = { "feed1": new WebSocket("ws://" + window.location.hostname + ":8888/input1/"), "feed2": new WebSocket("ws://" + window.location.hostname + ":8888/input2/") };
var selected_topic = {"feed1": "None", "feed2": "None"};
var filter_metadata = null;
var external_inputs = {}

///////////////////////////////////////////////////////////////////////////////
//                            ACCESSOR FUNCTIONS                             //
///////////////////////////////////////////////////////////////////////////////
function filtergroups(filter_group_name) {
    if(filter_group_name == undefined || /^\s*$/.test(filter_group_name)) {
        return $('.filtergroup');
    } else {
        return $('.filtergroup').filter(function () {
            return $(this).find(".filtergroup-name").text() === filter_group_name;
        });
    }
}

function filters(filter_group_name, filter_name) {
    if(filter_name == undefined || /^\s*$/.test(filter_name)) {
        return filtergroups(filter_group_name).find('.filtergroup-body').children('.filter');
    } else {
        return filtergroups(filter_group_name).find('.filtergroup-body').find('.filter-name:contains("' + filter_name + '")').closest(".filter");
    }
}

function max_padding() {
    var groups = []

    $(".filtergroup-body").map(function (i) {
        groups[i] = $(this).children().length;
    });

    return Math.max.apply(Math, groups) - 2;
}

///////////////////////////////////////////////////////////////////////////////
//                        DOM MODIFICATION FUNCTIONS                         //
///////////////////////////////////////////////////////////////////////////////

function create_filter_group(filter_group_name, position) {
    var new_filter_group = $('<div class="filtergroup"><div class="filtergroup-header input-group input-group-lg"><span class="filtergroup-name input-group-addon"></span><span class="input-group-btn"><button class="edit-filtergroup btn btn-default" type="button"><span class="glyphicon glyphicon-pencil"></span></button><button class="delete-filtergroup btn btn-default" type="button"><span class="glyphicon glyphicon-remove"></span></button></span></div><div class="filtergroup-body well well-sm"><div class="add-filter-container left sort-disabled btn-group"><button type="button" class="add-filter left btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="glyphicon glyphicon-plus"></span></button></div><div class="add-filter-container right sort-disabled"><button type="button" class="add-filter right btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="glyphicon glyphicon-plus"></span></button></div></div></div>');

    var filter_picker = $('<ul class="dropdown-menu" role="menu"></ul>').on('click', 'li a', function() {
        var type = $(this).text();
        var position = 1;
        var add_filter_button = $(this).closest(".add-filter-container");

        if($(this).closest(".add-filter-container").prop("class").split(" ").indexOf("right") > -1) {
            position = filters(filter_group_name).size() + 1;
        }

        $("#edit-filter-name").off("input");
        $("#edit-filter-name").on("input", function() {
            var filter_names = new_filter_group.find(".filter-name").map(function() { return $(this).text(); }).get();

            if($.trim($(this).val()) == "" || $.inArray($(this).val().replace(/\s+/g, "-").toLowerCase(), filter_names) > -1) {
                $(".ui-dialog-buttonpane button:contains('Filter')").button("disable");
            } else {
                $(".ui-dialog-buttonpane button:contains('Filter')").button("enable");
            }
        });

        function addFilter() {
            var order = 0;
            create_filter(filter_group_name, $("#edit-filter-name").val(), type, {}, position);

            filters(filter_group_name).each(function() {
                if($(this).find(".filter-name").text() === $("#edit-filter-name").val()) return false;
                order++;
            });

            $("#filter-dialog").dialog( "close" );
            send_create_filter(filter_group_name, $("#edit-filter-name").val(), type, order);
        }

        $("#filter-dialog").dialog({
            resizable: false,
            height: 220,
            modal: true,
            buttons: {
                "Add Filter": addFilter,
                Cancel: function() {
                    $("#edit-filter-name").val("");
                    $(this).dialog( "close" );
                }
            }
        });

        $("#edit-filter-name").val("").keypress(function(e) {
            if(e.keyCode == 13) {
                addFilter();
            }
        });
        $(".ui-dialog-buttonpane button:contains('Add Filter')").button("disable");
    });

    $.each(filter_metadata, function(i, f) {
        $(filter_picker).append($('<li><a href="#">' + f.name + '</a></li>'));
    });

    position = default_value(position, $("#workspace").children().size() - 1);
    insert_at($("#workspace"), new_filter_group, position);

    for(var i = 0; i < max_padding(); i++) {
        insert_at(new_filter_group.find(".filtergroup-body"), padding.clone(), 0);
    }

    new_filter_group.find(".filtergroup-name").text(filter_group_name);
    new_filter_group.find(".add-filter-container.left").append($(filter_picker).clone(true));
    new_filter_group.find(".add-filter-container.right").append($(filter_picker).clone(true));
    new_filter_group.find(".dropdown-menu").last().addClass("pull-right");

    // Edit Filter Group
    new_filter_group.find(".edit-filtergroup").click(function () {
        $(".ui-dialog-buttonpane button:contains('Edit Filter Group')").button("enable");

        $("#edit-filtergroup-name").off("input");
        $("#edit-filtergroup-name").on("input", function() {
            var filtergroup_names = $(".filtergroup-name").map(function() { return $(this).text(); }).get();

            filtergroup_names.splice(filtergroup_names.indexOf(filter_group_name), 1);

            if($.trim($(this).val()) == "" || $.inArray($(this).val().replace(/\s+/g, "-").toLowerCase(), filtergroup_names) > -1) {
                $(".ui-dialog-buttonpane button:contains('Filter Group')").button("disable");
            } else {
                $(".ui-dialog-buttonpane button:contains('Filter Group')").button("enable");
            }
        });

        $( "#filtergroup-dialog" ).dialog({
            resizable: false,
            height: 220,
            modal: true,
            buttons: {
                "Edit Filter Group": function() {
                    send_edit_filter_group(filter_group_name, { "name": $("#edit-filtergroup-name").val() });
                    new_filter_group.find(".filtergroup-name").text($("#edit-filtergroup-name").val());
                    $(this).dialog( "close" );
                },
                Cancel: function() {
                    $("#edit-filtergroup-name").val("");
                    $(this).dialog( "close" );
                }
            }
        });

        $("#edit-filtergroup-name").val(filter_group_name);
    });

    // Delete Filter Group
    new_filter_group.find(".delete-filtergroup").click(function () {
        remove_filter_group(filter_group_name);
        send_delete_filter_group(filter_group_name);
    });

    new_filter_group.find(".filtergroup-body").sortable({
        tolerance: "pointer",
        scroll: false,
        items: ".filter",
        cancel: ".sort-disabled",
        connectWith: ".filtergroup-body",
        containment: "#workspace",
        placeholder: "filter-placeholder",
        sort: function(event, ui) {
            update_sortable_filters();
            jsp.repaintEverything();
        },
        stop: function(event, ui) {
            update_sortable_filters();
            jsp.repaintEverything();
        },
        update: function(event, ui) {
            update_sortable_filters();
            ui.item.closest(".filtergroup-body").children(".inactive").last().remove();
            jsp.repaintEverything();
            //FIX ME PADDING
        }
    });

    jsp.repaintEverything();
}

function remove_filter_group(filter_group_name) {
    filtergroups(filter_group_name).find(".filter-inputs").each(function (index) {
        jsp.removeAllEndpoints($(this));
    });

    filtergroups(filter_group_name).find(".filter-outputs").each(function (index) {
        jsp.removeAllEndpoints($(this));
    });

    filtergroups(filter_group_name).remove();

    jsp.repaintEverything();
}

function create_filter(filter_group_name, filter_name, type, options, position) {
    var new_filter = $('<div class="filter sort-disabled panel panel-default"><div class="filter-header panel-heading"><span class="filter-type label label-primary"></span><span class="filter-name"></span><span class="filter-controls btn-group"><button class="edit-filter btn btn-default" type="button"><span class="glyphicon glyphicon-pencil"></span></button><button class="delete-filter btn btn-default" type="button"><span class="glyphicon glyphicon-remove"></span></button></span></div><div class="filter-body panel-body"><div class="filter-inputs"></div><div class="filter-outputs"></div></div></div>');
    var filter_info = filter_metadata.filter(function (f) { return f.type == type; })[0];
    var description = default_value(options.description, filter_info.description);
    var inputs = default_value(options.inputs, filter_info.inputs);
    var outputs = default_value(options.outputs, filter_info.outputs);
    var parameters = default_value(options.parameters, filter_info.parameters);

    position = default_value(position, filtergroups(filter_group_name).find(".filtergroup-body").children().size() - 1);

    if(filtergroups(filter_group_name).find(".filtergroup-body").children(":nth-child(" + position + ")").hasClass("inactive")) {
        filtergroups(filter_group_name).find(".filtergroup-body").children(":nth-child(" + position + ")").remove();
        position--;
    }

    insert_at(filtergroups(filter_group_name).find(".filtergroup-body"), new_filter, position);

    $('.filtergroup-name:not(:contains("' + filter_group_name + '"))').closest(".filtergroup").find(".filtergroup-body").each(function(index, element) {
        for(var i = 0; i < filtergroups(filter_group_name).find(".filtergroup-body").children().length - $(element).children().length; i++) {
            insert_at($(element), padding.clone(), $(element).children().length - 1);
        }
    });

    update_sortable_filters();

    new_filter.find(".filter-name").text(filter_name);
    new_filter.find(".filter-type").text(type);

    // Initialize Filter Inputs
    for(i in inputs) {
        jsp.addEndpoint(new_filter.find(".filter-inputs"),
                        {
                            uuid: "__" + filter_group_name + "__" + filter_name + "__" + inputs[i].name,
                            anchor:[0.5, (parseInt(i) + 1) * (1.0 / (inputs.length + 1)), -1, 0]
                        },
                        {
                            endpoint: ["Dot", {radius: 10} ],
                            cssClass: "input",
                            hoverClass: "input-hover",
                            paintStyle: { fillStyle: "#d9534f", opacity: 0.5 },
                            isTarget: true,
                            scope: inputs[i].type,
                            overlays:[
                                [ "Label", { location: [0, -1.2], label: '<span class="input-type label label-danger">' + inputs[i].type + '</span>&nbsp;<strong class="input-name">' + inputs[i].name + '</strong>', cssClass: "input-label" } ]
                            ]
                        }
                       );
    }

    // Initialize Filter Outputs
    for(i in outputs) {
        jsp.addEndpoint(new_filter.find(".filter-outputs"),
                        {
                            uuid: "__" + filter_group_name + "__" + filter_name + "__" + outputs[i].name,
                            anchor:[0.5, (parseInt(i) + 1) * (1.0 / (outputs.length + 1)), 1, 0]
                        },
                        {
                            endpoint: ["Dot", {radius: 10} ],
                            cssClass: "output",
                            hoverClass: "output-hover",
                            paintStyle: { fillStyle: "#5bc0de", opacity: 0.5 },
                            isSource: true,
                            scope: outputs[i].type,
                            maxConnections: -1,
                            connector: [ "Bezier" ],
                            connectorStyle: {
                                gradient: { stops:[ [ 0, "#5bc0de" ], [ 1, "#d9534f" ] ] },
                                strokeStyle: "#d9534f",
                                lineWidth: 5
                            },
                            overlays:[
                                [ "Label", { location: [0, -1.2], label: '<span class="input-type label label-info">' + outputs[i].type + '</span>&nbsp;<strong class="input-name">' + outputs[i].name + '</strong>', cssClass: "output-label" } ]
                            ]
                        }
                       );
    }

    // Show Filter Properties
    new_filter.click(function() {
        $("#properties-container").children().show();
        $("#filter-type-name").text(type);
        $("#filter-type-description").text(description);
        $("#filter-properties").empty();

        $.each(parameters, function (i, p) {
            var parameter_container = $('<div class="form-group"><label for="' + p.name + '" class="parameter-name control-label">' + p.name + '</label><div class="input-group"><span class="input-group-btn"><button class="reset-parameter btn btn-default" type="button">Reset</button></span></div></div>');

            switch(p.type) {
                // String parameter
            case "str":
                var select_options = null;

                // FIXME: This shouldn't be in the "min" parameter...
                try {
                    select_options = JSON.parse(p.min.replace(/'/g, "\""));
                } catch(err) { }

                // Is it a dropdown list?
                if($.isArray(select_options)) {
                    parameter_container.find(".input-group").prepend($('<select id="' + p.name + '" class="parameter-value form-control" />'));

                    $.each(select_options, function (index, option) {
                        parameter_container.find("#" + p.name).append($("<option>", {text: option, value: option}));
                    });

                    parameter_container.find("#" + p.name).change(function () { send_set_parameter(filter_group_name, filter_name, p.name, $(this).val()) });
                } else {
                    parameter_container.find(".input-group").prepend($('<input id="' + p.name + '" type="text" class="parameter-value form-control" value="' + p.default + '" />'));
                    parameter_container.find("#" + p.name).on("input", function () { send_set_parameter(filter_group_name, filter_name, p.name, $(this).val()) });
                }

                parameter_container.find(".reset-parameter").click(function() {
                    $("#" + p.name).val(p.default);
                });
                break;

                // Numeric parameter
            case "float":
            case "int":
                parameter_container.find(".input-group").prepend($('<input id="' + p.name + '" type="text" class="parameter-value form-control" value="' + p.default + '" />'));

                if($.isNumeric(p.min) && $.isNumeric(p.max)) {
                    parameter_container.find(".input-group").before($('<div id="' + p.name + '-slider" class="slider"></div>'));
                }

                parameter_container.find("#" + p.name).on("input", function () {
                    if($.isNumeric($(this).val())) {
                        $("#" + p.name + "-slider").slider("value", $(this).val());
                        send_set_parameter(filter_group_name, filter_name, p.name, $(this).val());
                    }
                });

                parameter_container.find(".reset-parameter").click(function() {
                    $("#" + p.name).val(p.default);
                });
                break;

                // Boolean parameter
            case "bool":
                parameter_container.find(".input-group").prepend($('<input id="' + p.name + '" type="checkbox" class="parameter-value form-control" />'));

                parameter_container.find(".reset-parameter").click(function() {
                    $("#" + p.name).prop('checked', p.default);
                });

                parameter_container.find("#" + p.name).change(function () { send_set_parameter(filter_group_name, filter_name, p.name, $(this).val()) });
                break;
            }

            $("#filter-properties").append(parameter_container);
            send_get_parameter(filter_group_name, filter_name, p.name);

            if($.isNumeric(p.min) && $.isNumeric(p.max)) {
                var step = (p.type == "float") ? 0.1 : 1;

                $("#" + p.name + "-slider").slider({
                    value: p.default,
                    min: parseInt(p.min),
                    max: parseInt(p.max),
                    step: step,
                    slide: function( event, ui ) {
                        $("#" + p.name).val(ui.value);
                        send_set_parameter(filter_group_name, filter_name, p.name, ui.value);
                    }
                });
            }
        });

        $(".selected-filter").removeClass("selected-filter");
        $(this).addClass("selected-filter");
    });

    // Edit Filter
    new_filter.find(".edit-filter").click(function () {
        $("#edit-filter-name").off("input");
        $("#edit-filter-name").on("input", function() {
            var filter_names = new_filter_group.find(".filter-name").map(function() { return $(this).text(); }).get();

            filter_names.splice(filter_names.indexOf(filter_name), 1);

            if($.trim($(this).val()) == "" || $.inArray($(this).val().replace(/\s+/g, "-").toLowerCase(), filter_names) > -1) {
                $(".ui-dialog-buttonpane button:contains('Filter')").button("disable");
            } else {
                $(".ui-dialog-buttonpane button:contains('Filter')").button("enable");
            }
        });

        $("#filter-dialog").dialog({
            resizable: false,
            height: 220,
            modal: true,
            buttons: {
                "Edit Filter": function() {
                    send_edit_filter(filter_group_name, filter_name, { "name": $("#edit-filter-name").val() });
                    new_filter.find("filter-name").text($("#edit-filter-name").val());
                    $(this).dialog( "close" );
                },
                Cancel: function() {
                    $("#edit-filter-name").val("");
                    $(this).dialog( "close" );
                }
            }
        });

        $("#edit-filter-name").val(filter_name).keypress(function(e) {
            if(e.keyCode == 13) {
                $("#filter-dialog").dialog('close');
            }
        });

        $(".ui-dialog-buttonpane button:contains('Edit Filter')").button("enable");
    });

    // Delete Filter
    new_filter.find(".delete-filter").click(function () {
        remove_filter(filter_group_name, filter_name);
        send_delete_filter(filter_group_name, filter_name);
    });

    jsp.repaintEverything();
}

function remove_filter(filter_group_name, filter_name) {
    var index = filters(filter_group_name, filter_name).index();

    jsp.removeAllEndpoints(filters(filter_group_name, filter_name).find(".filter-inputs"));
    jsp.removeAllEndpoints(filters(filter_group_name, filter_name).find(".filter-outputs"));
    filters(filter_group_name, filter_name).before(padding.clone());
    filters(filter_group_name, filter_name).remove();
    $(".filtergroup-body").children(".inactive:nth-child(" + (index + 1) + ")").remove();
    // FIXME: Pad filter groups?
    jsp.repaintEverything();
}

///////////////////////////////////////////////////////////////////////////////
//                           WEBSOCKET FUNCTIONS                             //
///////////////////////////////////////////////////////////////////////////////

function send_set_parameter(filter_group_name, filter_name, parameter_name, parameter_value) {
    master.send(JSON.stringify(
        {
            "set_parameter" :
            {
                "filter_name": filter_name,
                "filter_group_name": filter_group_name,
                "parameter_name" : parameter_name,
                "parameter_value" : parameter_value
            }
        }
    ));
}

function send_get_parameter(filter_group_name, filter_name, parameter_name) {
    master.send(JSON.stringify(
        {
            "get_parameter" :
            {
                "filter_name": filter_name,
                "filter_group_name": filter_group_name,
                "parameter_name" : parameter_name
            }
        }
    ));
}

function send_create_filtergroup(filter_group_name, order) {
    master.send(JSON.stringify(
        {
            "create_filtergroup" :
            {
                "filter_group_name": filter_group_name,
                "order": order
            }
        }
    ));
}

function send_edit_filter_group(filter_group_name, options) {
    //TODO
}

function send_delete_filter_group(filter_group_name) {
    master.send(JSON.stringify(
        {
            "delete_filtergroup" :
            {
                "filter_group_name": filter_group_name
            }
        }
    ));
}

function send_create_filter(filter_group_name, filter_name, type, order) {
    master.send(JSON.stringify({
        "create_filter": {
            "filter_group_name": filter_group_name,
            "filter_name": filter_name,
            "type": type,
            "order": order
        }
    }));
}

function send_edit_filter(filter_group_name, filter_name, options) {
    //TODO
}

function send_delete_filter(filter_group_name, filter_name) {
    master.send(JSON.stringify({
        "delete_filter": {
            "filter_group_name": filter_group_name,
            "filter_name": filter_name
        }
    }));
}

function on_connection_change(info, original_event) {
    master.send(JSON.stringify({
        "set_input": {
            "filter_group_name": $(info.target).closest(".filtergroup").find(".filtergroup-name").text(),
            "filter_name": $(info.target).closest(".filter").find(".filter-name").text(),
            "parameter_name": $(info.targetEndpoint.getOverlay().label).siblings(".input-name").text(),
            "parameter_value": (info.sourceEndpoint.getUuid() || info.sourceEndpoint.elementId).replace(/__/g, "/"),
            "source_id": (info.sourceEndpoint.getUuid() || info.sourceEndpoint.elementId),
            "target_id": info.targetEndpoint.getUuid(),
            "delete": false
        }
    }));
}

function on_connection_detached(info, original_event) {
    master.send(JSON.stringify({
        "set_input": {
            "filter_group_name": $(info.target).closest(".filtergroup").find(".filtergroup-name").text(),
            "filter_name": $(info.target).closest(".filter").find(".filter-name").text(),
            "parameter_name": $(info.targetEndpoint.getOverlay().label).siblings(".input-name").text(),
            "parameter_value": $(info.targetEndpoint.getOverlay().label).siblings(".input-name").text(),
            "source_id": (info.sourceEndpoint.getUuid() || info.sourceEndpoint.elementId),
            "target_id": info.targetEndpoint.getUuid(),
            "delete": true
        }
    }));
}

///////////////////////////////////////////////////////////////////////////////
//                             EVENT FUNCTIONS                               //
///////////////////////////////////////////////////////////////////////////////
// FIXME Remove this
function update_sortable_filters() {
    $.each($(".filtergroup-body"), function(index, filtergroup) {
        if($(filtergroup).find(".filter").length == 1) {
            $(filtergroup).find(".filter").addClass("sort-disabled");
        } else {
            $(filtergroup).find(".filter").removeClass("sort-disabled");
        }
    });
}

///////////////////////////////////////////////////////////////////////////////
//                             OTHER FUNCTIONS                               //
///////////////////////////////////////////////////////////////////////////////

function load_filter_chain(workspace) {
    // Clean up client
    jsp.deleteEveryEndpoint();
    $(".filtergroup").remove();

    // Initialize filters and filter groups
    for(group_index in workspace.filter_groups) {
        create_filter_group(workspace.filter_groups[group_index].name);

        for(filter_index in workspace.filter_groups[group_index].filters) {
            var filter_options = {
                description: workspace.filter_groups[group_index].filters[filter_index].description,
                inputs: workspace.filter_groups[group_index].filters[filter_index].inputs,
                outputs: workspace.filter_groups[group_index].filters[filter_index].outputs,
                parameters: workspace.filter_groups[group_index].filters[filter_index].parameters
            }

            create_filter(workspace.filter_groups[group_index].name, workspace.filter_groups[group_index].filters[filter_index].name, workspace.filter_groups[group_index].filters[filter_index].type, filter_options);
        }
    }

    // Initialize all connections
    jsp.unbind("connection");

    for(group_index in workspace.filter_groups) {
        for(filter_index in workspace.filter_groups[group_index].filters) {
            for(i in workspace.filter_groups[group_index].filters[filter_index].inputs) {
                var inputs = workspace.filter_groups[group_index].filters[filter_index].inputs;

                if(inputs[i].topic.replace(/\//g, '__') != "__" + workspace.filter_groups[group_index].name + "__" + workspace.filter_groups[group_index].filters[filter_index].name + "__" + inputs[i].name) {
                    var input_endpoint = jsp.getEndpoint(inputs[i].topic.replace(/\//g, '__')) || $("#" + inputs[i].topic.replace(/\//g, '__'));
                    var output_endpoint = jsp.getEndpoint("__" + workspace.filter_groups[group_index].name + "__" + workspace.filter_groups[group_index].filters[filter_index].name + "__" + inputs[i].name);

                    jsp.connect({ source: input_endpoint, target: output_endpoint});
                }
            }
        }
    }

    jsp.bind("connection", on_connection_change);

    optimize_filter_positions();
}

function optimize_filter_positions() {
    $(".filter.inactive").remove();

    jsp.selectEndpoints().each(function(endpoint) {
        for(i in endpoint.connections) {
            var source_filter = $(endpoint.connections[i].source).closest(".filter");
            var target_filter = $(endpoint.connections[i].target).closest(".filter");

            if(source_filter.closest(".filtergroup").find(".filtergroup-name").text() != target_filter.closest(".filtergroup").find(".filtergroup-name").text()) {
                var padding_count = source_filter.index() + 1 - target_filter.index();

                for(var j = 0; j < padding_count; j++) {
                    target_filter.before(padding.clone());
                }
            }
        }
    });

    jsp.repaintEverything();
}

function update_topic_list(data) {
    external_inputs = JSON.parse(data);

    // Update topic list for feeds
    for(var feed_id in input_feeds) {
        $("#" + feed_id + "-topics").empty();
        $("#" + feed_id + "-topics").append('<option value="None">None</option>');

        $.each(external_inputs, function(groupName, options) {
            var $optgroup = $("<optgroup>", {label: groupName});
            $optgroup.appendTo($("#" + feed_id + "-topics"));

            $.each(options, function(index, option) {
                var $option = $("<option>", {text: option, value: groupName});

                $option.appendTo($optgroup);
            });
        });

        $("#" + feed_id + "-topics option:contains(" + selected_topic[feed_id] + ")").attr('selected', true);
    }

    // Update external inputs list
    $.each(external_inputs, function(type, topics) {
        if($("#" + type.split(/\//).pop().toLowerCase() + "-inputs").length == 0) {
            $(".inputs-container").append($('<div id="' + type.split(/\//).pop().toLowerCase() + '-inputs" class="topic-inputs list-group"><a href="#" class="list-group-item"><h4 class="list-group-item-heading">' + type + '</h4></a></div>'));
        }

        $.each(topics, function(index, topic) {
            var topic_parts = topic.split(/\//);

            if(filters(topic_parts[1], topic_parts[2]).length == 0 && $("#" + topic.replace(/\//g, '__')).length == 0) {
                var input = $('<a href="#" class="list-group-item list-group-item-success">' + topic + '</a>');

                input.attr("id", topic.replace(/\//g, '__'));
                $("#" + type.split(/\//).pop().toLowerCase() + "-inputs").append(input);

                jsp.makeSource(input,
                               {
                                   anchor: "Right",
                                   scope: type,
                                   connector: [ "Flowchart", { stub: [10, 10], alwaysRespectStubs: true, midpoint: 0.05 } ],
                                   connectorStyle: {
                                       strokeStyle: "#d9534f",
                                       lineWidth: 4
                                   }
                               });
            } else if(filters(topic_parts[1], topic_parts[2]).length != 0 && $("#" + topic.replace(/\//g, '__')).length != 0) {
                jsp.detachAllConnections($("#" + topic.replace(/\//g, '__')));
                $("#" + topic.replace(/\//g, '__')).remove();
            }
        });
    });

    jsp.repaintEverything();
}

///////////////////////////////////////////////////////////////////////////////
//                            UTILITY FUNCTIONS                              //
///////////////////////////////////////////////////////////////////////////////

function default_value(arg, val) {
    return typeof arg !== 'undefined' ? arg : val;
}

function insert_at(container, element, index) {
    if(index < 1) {
        container.children(":nth-child(1)").after(element);
    } else {
        container.children(":nth-child(" + index + ")").after(element);
    }
}

function encode (input) {
    var keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    var output = "";
    var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
    var i = 0;

    while (i < input.length) {
        chr1 = input[i++];
        chr2 = i < input.length ? input[i++] : Number.NaN; // Not sure if the index
        chr3 = i < input.length ? input[i++] : Number.NaN; // checks are needed here

        enc1 = chr1 >> 2;
        enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
        enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
        enc4 = chr3 & 63;

        if (isNaN(chr2)) {
            enc3 = enc4 = 64;
        } else if (isNaN(chr3)) {
            enc4 = 64;
        }
        output += keyStr.charAt(enc1) + keyStr.charAt(enc2) +
            keyStr.charAt(enc3) + keyStr.charAt(enc4);
    }
    return output;
}

///////////////////////////////////////////////////////////////////////////////

jsPlumb.ready(function() {
    var load = new WebSocket("ws://" + window.location.hostname + ":8888/load/");
    var save = new WebSocket("ws://" + window.location.hostname + ":8888/save/");

    $(window).resize(function() {
        jsp.repaintEverything();
    });

    $("#properties-container").children().hide();
    $("#load-workspace").prop('disabled', true);
    $("#save-workspace").prop('disabled', true);
    $("#feed1").attr("src", "images/no_feed.png");
    $("#feed2").attr("src", "images/no_feed.png");

    input_feeds["feed1"].binaryType = 'arraybuffer';
    input_feeds["feed2"].binaryType = 'arraybuffer';

    input_feeds["feed1"].onmessage = function(evt) {
        if(evt.data != null) {
            var image = encode(new Uint8Array(evt.data));

            if(image !== "") {
                $("#feed1").attr("src", "data:image/jpeg;base64," + image);
            } else {
                $("#feed1").attr("src", "images/no_feed.png");
            }
        }
    };

    input_feeds["feed2"].onmessage = function(evt) {
        if(evt.data != null) {
            var image = encode(new Uint8Array(evt.data));

            if(image !== "") {
                $("#feed2").attr("src", "data:image/jpeg;base64," + image);
            } else {
                $("#feed2").attr("src", "images/no_feed.png");
            }
        }
    };

    $("#feed1-topics").change(function () {
        selected_topic["feed1"] = $("option:selected", this).text();
        input_feeds["feed1"].send([$("option:selected", this).text(), $("option:selected", this).val()]);
    });

    $("#feed2-topics").change(function () {
        selected_topic["feed2"] = $("option:selected", this).text();
        input_feeds["feed2"].send([$("option:selected", this).text(), $("option:selected", this).val()]);
    });

    topics.onmessage = function(evt) {
        update_topic_list(evt.data);
    };

    load.onmessage = function(evt) {
        $("#workspace-picker").empty();
        $("#workspace-picker").append($("<option selected disabled>Pick a filter chain...</option>"));

        $("#workspace-picker").change(function() {
            $("#load-workspace").prop('disabled', false);
        });

        $.each(JSON.parse(evt.data), function(i, fc) {
            $("#workspace-picker").append($("<option></option>").val(fc).text(fc));
        });
    };

    filter_types.onmessage = function(evt) {
        filter_metadata = JSON.parse(evt.data)
    };

    master.onmessage = function(evt) {
        var data = JSON.parse(evt.data);

        if(data.hasOwnProperty("parameter")) {
            $("#" + data.parameter.name).val(data.parameter.value);
            $("#" + data.parameter.name + "-slider").slider("value", data.parameter.value);
        } else if(data.hasOwnProperty("filter")) {
            if(data.filter.hasOwnProperty("type")) {
                create_filter(data.filter.filter_group_name, data.filter.filter_name, data.filter.type, {}, data.filter.order + 1);
            } else {
                remove_filter(data.filter.filter_group_name, data.filter.filter_name);
            }
        } else if(data.hasOwnProperty("filtergroup")) {
            if (data.filtergroup.hasOwnProperty("order")) {
                create_filter_group(data.filtergroup.filter_group_name, data.filtergroup.order + 1)
            } else {
                remove_filter_group(data.filtergroup.filter_group_name);
            }
        }
        else if(data.hasOwnProperty("input")) {
            jsp.unbind("connection");
            jsp.unbind("connectionDetached");

            if (!data.input.delete) {
                jsp.connect({ uuids: [data.input.source_id, data.input.target_id] });
            } else {
                jsp.detach({ uuids: [data.input.source_id, data.input.target_id] });
            }

            jsp.bind("connection", on_connection_change);
            jsp.bind("connection", on_connection_detached);
        }
        else if(data.hasOwnProperty("workspace")) {
            console.log("Loading Workspace...");
            load_filter_chain(data.workspace);
        }
    };

    $("#load-workspace").click(function () {
        $( "#load-dialog" ).dialog({
            resizable: false,
            height: 220,
            modal: true,
            buttons: {
                "Load Filter Chain": function() {
                    $(this).dialog( "close" );
                    $("#workspace-name").val($("#workspace-picker").val());
                    load.send($("#workspace-picker").val());
                },
                Cancel: function() {
                    $(this).dialog( "close" );
                }
            }
        });
    });

    $("#workspace-name").on("input", function() {
        $("#save-workspace").prop('disabled', $.trim($(this).val()) == "");
    });

    $("#save-workspace").click(function () {
        save.send($.trim($("#workspace-name").val().replace(/\s+/g, "__")));
    });

    $("#reset-workspace").click(function() {
        $(".delete-filtergroup").each(function () {
            $(this).trigger("click");
        });
    });

    $("#optimize-positions").click(function() {
        optimize_filter_positions();
    });

    $(".filtergroup-add").click(function () {
        var position = 1;

        if($(this).prop("class").split(" ").indexOf("bottom") > -1) {
            position = filtergroups().size() + 1;
        }

        $("#edit-filtergroup-name").off("input");
        $("#edit-filtergroup-name").on("input", function() {
            var filtergroup_names = $(".filtergroup-name").map(function() { return $(this).text(); }).get();

            if($.trim($(this).val()) == "" || $.inArray($(this).val().replace(/\s+/g, "-").toLowerCase(), filtergroup_names) > -1) {
                $(".ui-dialog-buttonpane button:contains('Filter Group')").button("disable");
            } else {
                $(".ui-dialog-buttonpane button:contains('Filter Group')").button("enable");
            }
        });

        $( "#filtergroup-dialog" ).dialog({
            resizable: false,
            height: 220,
            modal: true,
            buttons: {
                "Add Filter Group": function() {
                    var order = 0;

                    create_filter_group($("#edit-filtergroup-name").val().replace(/\s+/g, "-").toLowerCase(), position);

                    filtergroups().each(function() {
                        if($(this).find(".filtergroup-name").text() === $("#edit-filtergroup-name").val()) return false;
                        order++;
                    });

                    $(this).dialog( "close" );
                    send_create_filtergroup($("#edit-filtergroup-name").val().replace(/\s+/g, "-").toLowerCase(), order);
                    $("#edit-filtergroup-name").val("");
                },
                Cancel: function() {
                    $("#edit-filtergroup-name").val("");
                    $(this).dialog( "close" );
                }
            }
        });

        $(".ui-dialog-buttonpane button:contains('Add Filter Group')").button("disable");
    });

    jsp = jsPlumb.getInstance({
	Endpoint : ["Dot", {radius:2}],
	HoverPaintStyle : {strokeStyle:"#d9534f", lineWidth:2 },
	ConnectionOverlays : [
	    [ "Arrow", {
		location:1,
		id:"arrow",
                length:14,
                foldback:0.8
	    } ]
	],
	Container:"gui-body"
    });

    jsp.doWhileSuspended(function() {
        jsp.bind("connection", on_connection_change);
        jsp.bind("connectionDetached", on_connection_detached);
    });
});
