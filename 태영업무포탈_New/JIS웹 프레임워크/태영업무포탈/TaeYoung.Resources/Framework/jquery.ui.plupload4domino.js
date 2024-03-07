var FILEUPLOAD = new Array();
(function (window, document, plupload, o, $) {
	var uploaders = {};
	function _(str) {return plupload.translate(str) || str;}
	function renderUI(obj) {
		obj.id = obj.attr('id');
		var simpleMode = obj.attr("SimpleMode") ? obj.attr("SimpleMode").toLowerCase() === 'true' : false;
		var width = $(obj).width();
		var Minimal = width > 250;
		var display = "";
		var name_width = "";
		if (!Minimal) {
			display = 'style="display:none;"';
			name_width = 'style="width:120px;"';
		}
		var s = '';
		if (!simpleMode) {
			name_width = 'style="width:250px;"';
			s = '<div class="plupload_wrapper">' +
			'<div class="ui-widget-content plupload_container">' +
			'<table class="plupload_filelist plupload_filelist_header ui-widget-header">' +
			'<tr>' +
					'<td class="plupload_cell plupload_file_name" ' + name_width + '>' + _('Filename') + '</td>' +
					'<td class="plupload_cell plupload_file_status" ' + display + '>' + _('Status') + '</td>' +
					'<td class="plupload_cell plupload_file_size" ' + display + '>' + _('Size') + '</td>' +
					'<td class="plupload_cell plupload_file_action">&nbsp;</td>' +
			'</tr>' +
			'</table>' +
			'<div class="plupload_content">' +
					'<div class="plupload_droptext">' + '</div>' + // + _("Drag files here.") + '</div>' +
					'<ul class="plupload_filelist_content"> </ul>' +
					'<div class="plupload_clearer">&nbsp;</div>' +
			'</div>' +
			'<table class="plupload_filelist plupload_filelist_footer ui-widget-header">' +
			'<tr>' +
					'<td class="plupload_cell plupload_file_name">' +
			'<div class="plupload_buttons">' +
			'<a class="plupload_button plupload_add">' + _('Add Files') + '</a>&nbsp;' +
			'<a class="plupload_button plupload_start" style="display:none;">' + _('Start Upload') + '</a>&nbsp;' +
			'<a class="plupload_button plupload_stop plupload_hidden" style="display:none;">' + _('Stop Upload') + '</a>&nbsp;' +
			'</div>' +
			'<div class="plupload_started plupload_hidden">' +
			'<div class="plupload_progress plupload_right">' +
			'<div class="plupload_progress_container"></div>' +
			'</div>' +
			'<div class="plupload_cell plupload_upload_status"></div>' +
			'<div class="plupload_clearer">&nbsp;</div>' +
			'</div>' +
			'</td>' +
			'<td class="plupload_file_status" ' + display + '><span class="plupload_total_status">0%</span></td>' +
			'<td class="plupload_file_size" ' + display + '><span class="plupload_total_file_size">0 kb</span></td>' +
			'<td class="plupload_file_action" ' + display + '></td>' +
			'</tr>' +
			'</table>' +
			'</div>' +
			'<input class="plupload_count" value="0" type="hidden">' +
			'</div>';
		} else {
			s = '<div class="plupload_wrapper">' +
			'<div class="plupload_container">' +
			'<table class="plupload_filelist plupload_filelist_footer">' +
			'<tr>' +
			'<td class="plupload_cell plupload_file_name" style="background-color:white;">' +
			'<div class="plupload_content" style="float:left;width:250px;min-height:30px;position:absolute;display:none;margin-top:37px;margin-left:10px;border:solid 1px #cccccc;background-color:#FFFFFF">' +
			'<div class="plupload_droptext">' + '</div>' + // + _("Drag files here.") + '</div>' +
			'<ul class="plupload_filelist_content"> </ul>' +
			'<div class="plupload_clearer">&nbsp;</div>' +
			'</div>' +
			'<div class="plupload_buttons" style="float:left;">' +
			'<a class="plupload_button plupload_add">' + _('Add') + '</a>&nbsp;' +
			'<a class="plupload_button plupload_view">' + _('View') + '</a>&nbsp;' +
			'<a class="plupload_button plupload_start" style="display:none;">' + _('Start Upload') + '</a>&nbsp;' +
			'<a class="plupload_button plupload_stop plupload_hidden" style="display:none;">' + _('Stop Upload') + '</a>&nbsp;' +
			'</div>' +
			'</td>' +
			'</tr>' +
			'</table>' +
			'</div>' +
			'<input class="plupload_count" value="0" type="hidden">' +
			'</div>';
		}
		obj.html(s);
	}
	$.widget("ui.plupload", {
		widgetEventPrefix: '',
		contents_bak: '',
		options: {
			browse_button_hover: 'ui-state-hover',
			browse_button_active: 'ui-state-active',
			// widget specific
			dragdrop: true,
			multiple_queues: true, // re-use widget by default
			buttons: {
				browse: true,
				start: true,
				stop: true,
				view: true
			},
			views: {
				list: true,
				thumbs: false,
				active: 'list',
				remember: true // requires: https://github.com/carhartl/jquery-cookie, otherwise disabled even if set to true
			},
			autostart: false,
			sortable: false,
			rename: false,
			max_file_count: 0 // unlimited
		},
		FILE_COUNT_ERROR: -9001,
		_create: function () {
			var id = this.element.attr('id');
			if (!id) {
				id = plupload.guid();
				this.element.attr('id', id);
			}
			this.id = id;
			// SimpleMode 체크
			this.SimpleMode = $("#" + this.id).attr("SimpleMode") ? $("#" + this.id).attr("SimpleMode").toLowerCase() == "true" : false;
			// backup the elements initial state
			this.contents_bak = this.element.html();
			renderUI(this.element);

			// container, just in case
			this.container = $('.plupload_container', this.element).attr('id', id + '_container');
			this.content = $('.plupload_content', this.element);
			if ($.fn.resizable) {
				this.container.resizable({
					handles: 's'//,
					//minHeight: 300
				});
			}

			// list of files, may become sortable
			this.filelist = $('.plupload_filelist_content', this.container)
			.attr({
				id: id + '_filelist',
				unselectable: 'on'
			});

			// buttons
			this.browse_button = $('.plupload_add', this.container).attr('id', id + '_browse');
			this.view_button = $('.plupload_view', this.container).attr('id', id + '_view'); // 보기 버튼(심플모드)
			this.start_button = $('.plupload_start', this.container).attr('id', id + '_start');
			this.stop_button = $('.plupload_stop', this.container).attr('id', id + '_stop');
			this.thumbs_switcher = $('#' + id + '_view_thumbs');
			this.list_switcher = $('#' + id + '_view_list');

			if ($.ui.button) {
				this.browse_button.button({
					icons: { primary: 'ui-icon-circle-plus' },
					disabled: true
				});
				this.view_button.button({
					icons: { primary: 'ui-icon-circle-zoomin' },
					disabled: true
				});
				this.start_button.button({
					icons: { primary: 'ui-icon-circle-arrow-e' },
					disabled: true
				});
				this.stop_button.button({
					icons: { primary: 'ui-icon-circle-close' }
				});
				this.list_switcher.button({
					text: false,
					icons: { secondary: "ui-icon-grip-dotted-horizontal" }
				});
				this.thumbs_switcher.button({
					text: false,
					icons: { secondary: "ui-icon-image" }
				});
			}

			// progressbar
			this.progressbar = $('.plupload_progress_container', this.container);
			if ($.ui.progressbar) this.progressbar.progressbar();

			// counter
			this.counter = $('.plupload_count', this.element)
			.attr({
				id: id + '_count',
				name: id + '_count'
			});

			// initialize uploader instance
			this._initUploader();
		},

		_initUploader: function () {
			var self = this, id = this.id, uploader, options = {
				container: id + '_buttons',
				browse_button: id + '_browse',
				view_button: id + '_browse'
			};
			// 현재객체를 배열에 저장
			FILEUPLOAD.push(this);
			$('.plupload_buttons', this.element).attr('id', id + '_buttons');
			if (self.options.dragdrop) {
				this.filelist.parent().attr('id', this.id + '_dropbox');
				options.drop_element = this.id + '_dropbox';
			}
			uploader = this.uploader = uploaders[id] = new plupload.Uploader($.extend(this.options, options));
			if (self.options.views.thumbs) {
				uploader.settings.required_features.display_media = true;
			}
			uploader.bind('Error', function (up, err) {
				var message, details = "";
				message = '' + err.message + '';
				switch (err.code) {
					case plupload.FILE_EXTENSION_ERROR:
						details = o.sprintf(_("File: %s"), err.file.name);
						break;
					case plupload.FILE_SIZE_ERROR:
						details = o.sprintf(_("File: %s, size: %d, max file size: %d"), err.file.name, err.file.size, plupload.parseSize(self.options.max_file_size));
						break;
					case plupload.FILE_DUPLICATE_ERROR:
						details = o.sprintf(_("%s already present in the queue."), err.file.name);
						break;
					case self.FILE_COUNT_ERROR:
						details = o.sprintf(_("Upload element accepts only %d file(s) at a time. Extra files were stripped."), self.options.max_file_count);
						break;
					case plupload.IMAGE_FORMAT_ERROR:
						details = _("Image format either wrong or not supported.");
						break;
					case plupload.IMAGE_MEMORY_ERROR:
						details = _("Runtime ran out of available memory.");
						break;
					/* // This needs a review
					case plupload.IMAGE_DIMENSIONS_ERROR :
					details = o.sprintf(_('Resoultion out of boundaries! <b>%s</b> runtime supports images only up to %wx%hpx.'), up.runtime, up.features.maxWidth, up.features.maxHeight);
					break;	*/ 
					case plupload.HTTP_ERROR:
						details = _("Upload URL might be wrong or doesn't exist.");
						break;
				}
				message += " \n" + details + "";
				self._trigger('error', null, { up: up, error: err });
				// do not show UI if no runtime can be initialized
				if (err.code === plupload.INIT_ERROR) {
					setTimeout(function () {self.destroy();}, 1);
				} else {
					self.notify('error', message);
					alert(message);
				}
			});


			uploader.bind('PostInit', function (up) {
				var readmode = "";
				self.ReadMode = up.getOption("readmode");
				// all buttons are optional, so they can be disabled and hidden
				if (!self.options.buttons.browse) {
					self.browse_button.button('disable').hide();
					up.disableBrowse(true);
				} else {
					if (self.SimpleMode && self.ReadMode) {
						self.browse_button.button('disable').hide();
						// 버튼위에 레이어로 파일선택창 띄우는부분도 숨김
						self.browse_button.parent().find("div").hide();
					} else {
						self.browse_button.button('enable');
					}
				}
				if (!self.options.buttons.view) {
					self.view_button.button('disable').hide();
					up.disableBrowse(true);
				} else {
					self.view_button.button('enable');
				}
				if (!self.options.buttons.start) {
					self.start_button.button('disable').hide();
				}
				if (!self.options.buttons.stop) {
					self.stop_button.button('disable').hide();
				}
				if (!self.options.unique_names && self.options.rename) {
					self._enableRenaming();
				}
				if (self.options.dragdrop && up.features.dragdrop) {
					self.filelist.parent().addClass('plupload_dropbox');
				}
				self._enableViewSwitcher();
				self.start_button.click(function (e) {
					if (!$(this).button('option', 'disabled')) {
						self.start();
					}
					e.preventDefault();
				});
				self.view_button.click(function (e) {
					if (self.view_button.find(".ui-button-text").text().split('(')[0] == "View") {
						self.FileListShow(self.view_button.find(".ui-button-text"));
					} else {
						self.FileListHide(self.view_button.find(".ui-button-text"));
					}
				});
				self.stop_button.click(function (e) {
					self.stop();
					e.preventDefault();
				});
				self._trigger('ready', null, { up: up });
				var width = $(self.filelist).width();
				var Minimal = width > 250;
				var display = "";
				var name_width = "";
				if (!Minimal) {
					display = 'style="display:none;"';
					name_width = 'width:120px;';
				}
				if (self.ReadMode) {
					readmode = "display:none;";
					if (self.SimpleMode) $("#" + self.id).find(".plupload_filelist_footer").show();
					else $("#" + self.id).find(".plupload_filelist_footer").hide();
				}
				if (self.SimpleMode) name_width = 'width:250px;';
				// 초기 데이터 로드
				var file_html = '<li class="plupload_file ui-state-default" id="%id%">' +
					'<div class="plupload_file_thumb plupload_file_thumb_reload">' +
					//'<img src="/Resources/Framework/ImageResize.aspx?UNID=%unid%&width=100&height=60" onclick="__ImageViewer(\'%unid%\');" style="cursor:pointer;" alt="%name%" />' +
					'</div>' +
					'<div class="plupload_file_name" title="%name%" onclick="__FileDownloadLink(\'%src%\');" style="cursor:pointer;' + name_width + '" onmouseover="$(this).find(\'span\').css(\'color\',\'#F4A460\');" onmouseout="$(this).find(\'span\').css(\'color\',\'#646464\');"><span class="plupload_file_extspan"><img src="/Resources/Images/ext/%ext%.gif" onerror="/Resources/Images/ext/common.gif" alt="" style="vertical-align:middle" /></span><span class="plupload_file_namespan">%name%</span></div>' +
					'<div class="plupload_file_action"><div class="ui-icon ui-icon-circle-minus" onclick="__ImageDelete(this,\'%unid%\');" style="cursor:pointer;' + readmode + '"> </div></div>' +
					'<div class="plupload_file_size" ' + display + '>%size% </div>' +
					'<div class="plupload_file_status" ' + display + '>' +
						'<div class="plupload_file_progress ui-widget-header" style="width: 0%"> </div>' +
						'<span class="plupload_file_percent">%percent% </span>' +
					'</div>' +
					'<div class="plupload_file_fields"> </div>' +
					'</li>';
				// 내부 내용 삭제
				self.filelist.find("li").remove();
				// 데이터 로드
				// 초기화시 저장된 데이터를 바인딩한다.
				var data = $("#" + id + "_viewdata").val();
				var _files = new Array();
				if (data != "") {
					var data01 = data.split('^');
					for (var i = 0; i < data01.length; i++) {
						var data02 = data01[i].split('|');
						var obj = new Object();
						obj["name"] = data02[0];
						obj["size"] = data02[1];
						obj["ext"] = o.Mime.getFileExtension(obj.name) || 'none';
						obj["src"] = data02[2];
						obj["unid"] = data02[2].split('/$File/')[1];
						_files[i] = obj;
					}
					var cnt = 0;
					$.each(_files, function (i, file) {
						cnt = i + 1;
						var ext = o.Mime.getFileExtension(file.name) || 'none';
						self.filelist.append(file_html.replace(/%(\w+)%/g, function ($0, $1) {
							if ('size' === $1) {
								return file.size; // plupload.formatSize(file.size);
							} else if ('ext' === $1) {
								return ext;
							} else if ('unid' === $1) {
								return file.unid;
							} else {
								return file[$1] || '';
							}
						}));
					});
					// 심플모드일시 갯수만큼 View화면에 적용
					if (cnt > 0 && self.SimpleMode) {
						if (self.options.max_file_count > 0 && cnt >= self.options.max_file_count) {
							self.browse_button.button('disable');
							up.disableBrowse(true);
						}
						self.view_button.find(".ui-button-text").text("View" + "(" + cnt + ")");
					}
				}
			});

			// check if file count doesn't exceed the limit
			if (self.options.max_file_count) {
				self.options.multiple_queues = false; // one go only
				uploader.bind('FilesAdded', function (up, selectedFiles) {
					var selectedCount = selectedFiles.length;
					var aCat = $("[name='AttachCategory']").val().split(FIELD_SEP);
					var afile = $("[name='AttachFiles']").val().split(FIELD_SEP);
					var files = new Array();
					if(aCat.length == afile.length) {
						for(var i = 0; i < aCat.length; i++) {
							if(aCat[i] == self.id) {
								files.push(afile[i]);
							}
						}
					}
					var extraCount = files.length + up.files.length + selectedCount - self.options.max_file_count;
					if (extraCount > 0) {
						var ids = new Array();
						for(var i = 0; i < selectedFiles.length; i++) {
							ids.push(selectedFiles[i].id);
						}
						selectedFiles.splice(selectedCount - extraCount, extraCount);
						var exists = false;
						for(var i = 0; i < ids.length; i++) {
							exists = false;
							for(var j = 0; j < selectedFiles.length; j++) {
								if(ids[i] == selectedFiles[j].id) exists = true;
							}
							if(!exists) {
								$('#' + ids[i]).remove();
							}
						}

						up.trigger('Error', {
							code: self.FILE_COUNT_ERROR,
							message: _('File count error.')
						});
					}
				});
			}

			// uploader internal events must run first 
			uploader.init();
			uploader.bind('FileFiltered', function (up, file) {self._addFiles(file);});
			uploader.bind('FilesAdded', function (up, files) {
				self._trigger('selected', null, { up: up, files: files });
				// re-enable sortable
				if (self.options.sortable && $.ui.sortable) {
					self._enableSortingList();
				}
				self._trigger('updatelist', null, { filelist: self.filelist });
				if (self.SimpleMode) {
					var height = $("#" + self.id + "_dropbox").find("#" + self.id + "_filelist").height();
					$("#" + self.id + "_dropbox").css("height", height + "px");
				}
				if (self.options.autostart) {
					// set a little delay to make sure that QueueChanged triggered by the core has time to complete
					setTimeout(function () {
						self.start();
					}, 10);
				}
			});
			uploader.bind('FilesRemoved', function (up, files) {
				self._trigger('removed', null, { up: up, files: files });
				if (self.SimpleMode) {
					var height = $("#" + self.id + "_dropbox").find("#" + self.id + "_filelist").height();
					$("#" + self.id + "_dropbox").css("height", height + "px");
				}
			});
			uploader.bind('QueueChanged StateChanged', function () {
				self._handleState();
			});
			uploader.bind('UploadFile', function (up, file) {
				self._handleFileStatus(file);
			});
			uploader.bind('FileUploaded', function (up, file, result) {
				self._handleFileStatus(file);
				self._trigger('uploaded', null, { up: up, file: file });
				var data = $("#" + id + "_filedata").val();
				var category = $("[name='AttachCategory']").val().split(FIELD_SEP);
				var files = $("[name='AttachFiles']").val().split(FIELD_SEP);
				if (category[0] == "") {
					category = new Array();
					files = new Array();
				}
				category.push(id);
				files.push(file.name + "|" + file.size + "|" + file.type + "|" + result.response);
				data += file.name + "|" + file.size + "|" + file.type + "|" + result.response + "^";
				$("#" + id + "_filedata").val(data);
				$("[name='AttachCategory']").val(category.join(FIELD_SEP));
				$("[name='AttachFiles']").val(files.join(FIELD_SEP));
				__UploadComplete();
			});
			uploader.bind('UploadProgress', function (up, file) {
				self._handleFileStatus(file);
				self._updateTotalProgress();
				self._trigger('progress', null, { up: up, file: file });
			});
			uploader.bind('BeforeUpload', function (up, file) {
				up.settings.multipart_params = { 'filename': file.name };
			});
			uploader.bind('UploadComplete', function (up, files) {
				self._addFormFields();
				self._trigger('complete', null, { up: up, files: files });
			});
		},
		_setOption: function (key, value) {
			var self = this;
			if (key == 'buttons' && typeof (value) == 'object') {
				value = $.extend(self.options.buttons, value);
				if (!value.browse) {
					self.browse_button.button('disable').hide();
					self.uploader.disableBrowse(true);
				} else {
					self.browse_button.button('enable').show();
					self.uploader.disableBrowse(false);
				}
				if (!value.view) {
					self.view_button.button('disable').hide();
					self.uploader.disableBrowse(true);
				} else {
					self.view_button.button('enable').show();
					self.uploader.disableBrowse(false);
				}
				if (!value.start) {
					self.start_button.button('disable').hide();
				} else {
					self.start_button.button('enable').show();
				}
				if (!value.stop) {
					self.stop_button.button('disable').hide();
				} else {
					self.start_button.button('enable').show();
				}
			}
			self.uploader.settings[key] = value;
		},
		// 심플모드시 파일리스트 보이기
		FileListShow: function (obj) {
			$("#" + this.id + "_dropbox").show();
			obj.text("Close");
			var height = $("#" + this.id + "_dropbox").find("#" + this.id + "_filelist").height();
			$("#" + this.id + "_dropbox").css("height", height + "px");
		},
		// 심플모드시 파일리스트 숨기기
		FileListHide: function (obj) {
			var aCat = $("[name='AttachCategory']").val().split(FIELD_SEP);
			var afile = $("[name='AttachFiles']").val().split(FIELD_SEP);
			var files = new Array();
			if(aCat.length == afile.length) {
				for(var i = 0; i < aCat.length; i++) {
					if(aCat[i] == this.id) {
						files.push(afile[i]);
					}
				}
			}
			if(files.length > 0) obj.text("View(" + files.length + ")");
			else obj.text("View");
			$("#" + this.id + "_dropbox").hide();
		},
		FileCountCalcDomino: function() {
			var up = this.uploader;
			var aCat = $("[name='AttachCategory']").val().split(FIELD_SEP);
			var afile = $("[name='AttachFiles']").val().split(FIELD_SEP);
			var files = new Array();
			if(aCat.length == afile.length) {
				for(var i = 0; i < aCat.length; i++) {
					if(aCat[i] == this.id) {
						files.push(afile[i]);
					}
				}
			}
			if(this.options.max_file_count != 0 && files.length + up.files.length >= this.options.max_file_count) {
				this.browse_button.button('disable');
				up.disableBrowse(true);
			} else {
				this.browse_button.button('enable');
				up.disableBrowse(false);
			}
		},
		/**
		Start upload. Triggers `start` event.
		@method start
		*/
		start: function () {
			this.uploader.start();
			this._trigger('start', null, { up: this.uploader });
		},
		/**
		Stop upload. Triggers `stop` event.
		@method stop
		*/
		stop: function () {
			this.uploader.stop();
			this._trigger('stop', null, { up: this.uploader });
		},
		/**
		Enable browse button.
		@method enable
		*/
		enable: function () {
			this.browse_button.button('enable');
			this.view_button.button('enable');
			this.uploader.disableBrowse(false);
		},
		/**
		Disable browse button.
		@method disable
		*/
		disable: function () {
			this.browse_button.button('disable');
			this.view_button.button('disable');
			this.uploader.disableBrowse(true);
		},
		/**
		Retrieve file by it's unique id.
		@method getFile
		@param {String} id Unique id of the file
		@return {plupload.File}
		*/
		getFile: function (id) {
			var file;
			if (typeof id === 'number') file = this.uploader.files[id];
			else file = this.uploader.getFile(id);
			return file;
		},
		/**
		Return array of files currently in the queue.
		@method getFiles
		@return {Array} Array of files in the queue represented by plupload.File objects
		*/
		getFiles: function () {
			return this.uploader.files;
		},
		/**
		Remove the file from the queue.
		@method removeFile
		@param {plupload.File|String} file File to remove, might be specified directly or by it's unique id
		*/
		removeFile: function (file) {
			if (plupload.typeOf(file) === 'string') file = this.getFile(file);
			this._removeFiles(file);
		},
		/**
		Clear the file queue.
		@method clearQueue
		*/
		clearQueue: function () {
			this.uploader.splice();
		},
		/**
		Retrieve internal plupload.Uploader object (usually not required).
		@method getUploader
		@return {plupload.Uploader}
		*/
		getUploader: function () {
			return this.uploader;
		},
		/**
		Trigger refresh procedure, specifically browse_button re-measure and re-position operations.
		Might get handy, when UI Widget is placed within the popup, that is constantly hidden and shown
		again - without calling this method after each show operation, dialog trigger might get displaced
		and disfunctional.
		@method refresh
		*/
		refresh: function () {
			this.uploader.refresh();
		},
		/**
		Display a message in notification area.
		@method notify
		@param {Enum} type Type of the message, either `error` or `info`
		@param {String} message The text message to display.
		*/
		notify: function (type, message) {
			var popup = $(
				'<div class="plupload_message">' +
					'<span class="plupload_message_close ui-icon ui-icon-circle-close" title="' + _('Close') + '"></span>' +
					'<p><span class="ui-icon"></span>' + message + '</p>' +
				'</div>'
			);
			popup
				.addClass('ui-state-' + (type === 'error' ? 'error' : 'highlight'))
				.find('p .ui-icon').addClass('ui-icon-' + (type === 'error' ? 'alert' : 'info'))
				.end()
				.find('.plupload_message_close')
				.click(function () {popup.remove();})
				.end();
			$('.plupload_header', this.container).append(popup);
		},
		/**
		Destroy the widget, the uploader, free associated resources and bring back original html.
		@method destroy
		*/
		destroy: function () {
			this._removeFiles([].slice.call(this.uploader.files));
			// destroy uploader instance
			this.uploader.destroy();
			// unbind all button events
			$('.plupload_button', this.element).unbind();
			// destroy buttons
			if ($.ui.button) $('.plupload_add, .plupload_start, .plupload_stop', this.container).button('destroy');
			// destroy progressbar
			if ($.ui.progressbar) this.progressbar.progressbar('destroy');
			// destroy sortable behavior
			if ($.ui.sortable && this.options.sortable) $('tbody', this.filelist).sortable('destroy');
			// restore the elements initial state
			this.element.empty().html(this.contents_bak);
			this.contents_bak = '';
			$.Widget.prototype.destroy.apply(this);
		},
		_handleState: function () {
			var up = this.uploader;
			if (up.state === plupload.STARTED) {
				$(this.start_button).button('disable');
				$([]).add(this.stop_button).add('.plupload_started').removeClass('plupload_hidden');
				$('.plupload_upload_status', this.element).html(o.sprintf(_('Uploaded %d/%d files'), up.total.uploaded, up.files.length));
				$('.plupload_header_content', this.element).addClass('plupload_header_content_bw');
			} else if (up.state === plupload.STOPPED) {
				$([]).add(this.stop_button).add('.plupload_started').addClass('plupload_hidden');
				if (this.options.multiple_queues) {
					$('.plupload_header_content', this.element).removeClass('plupload_header_content_bw');
				} else {
					$([])
					.add(this.browse_button)
					//.add(this.view_button)
					.add(this.start_button)
					.button('disable');
					up.disableBrowse(true);

					if(this.options.max_file_count > 0) this.FileCountCalcDomino();
				}
				if (up.files.length === (up.total.uploaded + up.total.failed)) this.start_button.button('disable');
				else this.start_button.button('enable');
				this._updateTotalProgress();
			}

			if (up.total.queued === 0) {
				if (this.SimpleMode) $('.ui-button-text', this.browse_button).html(_('Add'));
				else $('.ui-button-text', this.browse_button).html(_('Add Files'));
			} else {
				if (this.SimpleMode) $('.ui-button-text', this.browse_button).html(o.sprintf(_('Add(%d)'), up.total.queued));
				else $('.ui-button-text', this.browse_button).html(o.sprintf(_('%d files queued'), up.total.queued));
			}
			up.refresh();
		},
		_handleFileStatus: function (file) {
			var self = this, actionClass, iconClass;
			// since this method might be called asynchronously, file row might not yet be rendered
			if (!$('#' + file.id).length) return;
			switch (file.status) {
				case plupload.DONE:
					actionClass = 'plupload_done';
					iconClass = 'ui-icon ui-icon-circle-check';
					break;
				case plupload.FAILED:
					actionClass = 'ui-state-error plupload_failed';
					iconClass = 'ui-icon ui-icon-alert';
					break;
				case plupload.QUEUED:
					actionClass = 'plupload_delete';
					iconClass = 'ui-icon ui-icon-circle-minus';
					break;
				case plupload.UPLOADING:
					actionClass = 'ui-state-highlight plupload_uploading';
					iconClass = 'ui-icon ui-icon-circle-arrow-w';
					// scroll uploading file into the view if its bottom boundary is out of it
					var scroller = $('.plupload_scroll', this.container)
						, scrollTop = scroller.scrollTop()
						, scrollerHeight = scroller.height()
						, rowOffset = $('#' + file.id).position().top + $('#' + file.id).height();
					if (scrollerHeight < rowOffset) scroller.scrollTop(scrollTop + rowOffset - scrollerHeight);
					// Set file specific progress
					$('#' + file.id)
					.find('.plupload_file_percent')
					.html(file.percent + '%')
					.end()
					.find('.plupload_file_progress')
					.css('width', file.percent + '%')
					.end()
					.find('.plupload_file_size')
					.html(plupload.formatSize(file.size));
					break;
			}
			actionClass += ' ui-state-default plupload_file';
			$('#' + file.id)
			.attr('class', actionClass)
			.find('.ui-icon')
			.attr('class', iconClass)
			.end()
			.filter('.plupload_delete, .plupload_done, .plupload_failed')
			.find('.ui-icon')
			.click(function (e) {
				self._removeFiles(file);
				e.preventDefault();
			});
		},
		_updateTotalProgress: function () {
			var up = this.uploader;
			// Scroll to end of file list
			this.filelist[0].scrollTop = this.filelist[0].scrollHeight;
			this.progressbar.progressbar('value', up.total.percent);
			this.element
			.find('.plupload_total_status')
			.html(up.total.percent + '%')
			.end()
			.find('.plupload_total_file_size')
			.html(plupload.formatSize(up.total.size))
			.end()
			.find('.plupload_upload_status')
			.html(o.sprintf(_('Uploaded %d/%d files'), up.total.uploaded, up.files.length));
		},
		_displayThumbs: function () {
			var self = this
			, tw, th // thumb width/height
			, cols
			, num = 0 // number of simultaneously visible thumbs
			, thumbs = [] // array of thumbs to preload at any given moment
			, loading = false;
			if (!this.options.views.thumbs) return;
			function onLast(el, eventName, cb) {
				var timer;
				el.on(eventName, function () {
					clearTimeout(timer);
					timer = setTimeout(function () {
						clearTimeout(timer);
						cb();
					}, 300);
				});
			}
			// calculate number of simultaneously visible thumbs
			function measure() {
				if (!tw || !th) {
					var wrapper = $('.plupload_file:eq(0)', self.filelist);
					tw = wrapper.outerWidth(true);
					th = wrapper.outerHeight(true);
				}
				var aw = self.content.width(), ah = self.content.height();
				cols = Math.floor(aw / tw);
				num = cols * (Math.ceil(ah / th) + 1);
			}
			function pickThumbsToLoad() {
				// calculate index of virst visible thumb
				var startIdx = Math.floor(self.content.scrollTop() / th) * cols;
				// get potentially visible thumbs that are not yet visible
				thumbs = $('.plupload_file', self.filelist).not("[id='']")
				.slice(startIdx, startIdx + num)
				.filter(':not(.plupload_file_thumb_loaded)')
				.get();
			}
			function init() {
				function mpl() {
					if (self.view_mode !== 'thumbs') return;
					measure();
					pickThumbsToLoad();
					lazyLoad();
				}
				if ($.fn.resizable) onLast(self.container, 'resize', mpl);
				onLast(self.window, 'resize', mpl);
				onLast(self.content, 'scroll', mpl);
				self.element.on('viewchanged selected', mpl);
				mpl();
			}
			function preloadThumb(file, cb) {
				// 업로드된 이미지 예외처리]
				if (file == undefined) return;
				var img = new o.Image();
				img.onload = function () {
					var thumb = $('#' + file.id + ' .plupload_file_thumb', self.filelist).html('');
					this.embed(thumb[0], {
						width: 100,
						height: 60,
						crop: true,
						swf_url: o.resolveUrl(self.options.flash_swf_url),
						xap_url: o.resolveUrl(self.options.silverlight_xap_url)
					});
				};
				img.bind("embedded error", function () {
					$('#' + file.id, self.filelist).addClass('plupload_file_thumb_loaded');
					this.destroy();
					setTimeout(cb, 1); // detach, otherwise ui might hang (in SilverLight for example)
				});
				img.load(file.getSource());
			}
			function lazyLoad() {
				if (self.view_mode !== 'thumbs' || loading) return;
				pickThumbsToLoad();
				if (!thumbs.length) return;
				loading = true;
				preloadThumb(self.getFile($(thumbs.shift()).attr('id')), function () {
					loading = false;
					lazyLoad();
				});
			}
			// this has to run only once to measure structures and bind listeners
			this.element.on('selected', function onselected() {
				self.element.off('selected', onselected);
				init();
			});
		},
		_addFiles: function (files) {
			var self = this, file_html;
			var width = $(self.filelist).width();
			var Minimal = width > 250;
			var display = "";
			var name_width = "";
			if (!Minimal) {
				display = 'style="display:none;"';
				name_width = 'style="width:120px;"';
			}
			if (this.SimpleMode) {
				name_width = 'style="width:250px;"';
				file_html = '<li class="plupload_file ui-state-default" id="%id%">' +
					'<div class="plupload_file_thumb">' +
					'<div class="plupload_file_dummy ui-widget-content"><span class="ui-state-disabled">%ext%</span></div>' +
					'</div>' +
					'<div class="plupload_file_name" title="%name%" ' + name_width + '><span class="plupload_file_extspan"><img src="/Resources/Images/ext/%ext%.gif" onerror="this.src=\'/Resources/Images/ext/common.gif\'" alt="" style="vertical-align:middle" /></span><span class="plupload_file_namespan">%name%</span></div>' +
					'<div class="plupload_file_action"><div class="ui-icon"> </div></div>' +
					'<div class="plupload_file_size" ' + display + '>%size% </div>' +
					'<div class="plupload_file_status" ' + display + '>' +
					'<div class="plupload_file_progress ui-widget-header" style="width: 0%"> </div>' +
					'<span class="plupload_file_percent">%percent% </span>' +
					'</div>' +
					'<div class="plupload_file_fields"> </div>' +
					'</li>';
			} else {
				file_html = '<li class="plupload_file ui-state-default" id="%id%">' +
					'<div class="plupload_file_thumb">' +
					'<div class="plupload_file_dummy ui-widget-content"><span class="ui-state-disabled">%ext%</span></div>' +
					'</div>' +
					'<div class="plupload_file_name" title="%name%" ' + name_width + '><span class="plupload_file_extspan"><img src="/Resources/Images/ext/%ext%.gif" onerror="/Resources/Images/ext/common.gif" alt="" style="vertical-align:middle" /></span><span class="plupload_file_namespan">%name%</span></div>' +
					'<div class="plupload_file_action"><div class="ui-icon"> </div></div>' +
					'<div class="plupload_file_size" ' + display + '>%size% </div>' +
					'<div class="plupload_file_status" ' + display + '>' +
					'<div class="plupload_file_progress ui-widget-header" style="width: 0%"> </div>' +
					'<span class="plupload_file_percent">%percent% </span>' +
					'</div>' +
					'<div class="plupload_file_fields"> </div>' +
					'</li>';
			}
			if (plupload.typeOf(files) !== 'array') files = [files];
			$.each(files, function (i, file) {
				var ext = o.Mime.getFileExtension(file.name) || 'none';
				self.filelist.append(file_html.replace(/%(\w+)%/g, function ($0, $1) {
					if ('size' === $1) return plupload.formatSize(file.size);
					else if ('ext' === $1) return ext;
					else return file[$1] || '';
				}));
				self._handleFileStatus(file);
			});
		},
		_removeFiles: function (files) {
			var self = this, up = this.uploader;
			if (plupload.typeOf(files) !== 'array') files = [files];
			// destroy sortable if enabled
			if ($.ui.sortable && this.options.sortable) $('tbody', self.filelist).sortable('destroy');
			$.each(files, function (i, file) {
				$('#' + file.id).toggle("highlight", function () {$(this).remove();});
				up.removeFile(file);
			});
			if (up.files.length) {
				// re-initialize sortable
				if (this.options.sortable && $.ui.sortable) this._enableSortingList();
			}
			this._trigger('updatelist', null, { filelist: this.filelist });
		},
		_addFormFields: function () {
			var self = this;
			// re-add from fresh
			$('.plupload_file_fields', this.filelist).html('');
			plupload.each(this.uploader.files, function (file, count) {
				var fields = '', id = self.id + '_' + count;
				if (file.target_name) fields += '<input type="hidden" name="' + id + '_tmpname" value="' + plupload.xmlEncode(file.target_name) + '" />';
				fields += '<input type="hidden" name="' + id + '_name" value="' + plupload.xmlEncode(file.name) + '" />';
				fields += '<input type="hidden" name="' + id + '_status" value="' + (file.status === plupload.DONE ? 'done' : 'failed') + '" />';
				$('#' + file.id).find('.plupload_file_fields').html(fields);
			});
			this.counter.val(this.uploader.files.length);
		},
		_viewChanged: function (view) {
			// update or write a new cookie
			if (this.options.views.remember && $.cookie) $.cookie('plupload_ui_view', view, { expires: 7, path: '/' });
			// ugly fix for IE6 - make content area stretchable
			if (o.Env.browser === 'IE' && o.Env.version < 7) {
				this.content.attr('style', 'height:expression(document.getElementById("' + this.id + '_container' + '").clientHeight - ' + (view === 'list' ? 133 : 103) + ');');
			}
			this.container.removeClass('plupload_view_list plupload_view_thumbs').addClass('plupload_view_' + view);
			this.view_mode = view;
			this._trigger('viewchanged', null, { view: view });
		},
		_enableViewSwitcher: function () {
			var self = this, view, switcher = $('.plupload_view_switch', this.container), buttons, button;
			plupload.each(['list', 'thumbs'], function (view) {
				if (!self.options.views[view]) switcher.find('[for="' + self.id + '_view_' + view + '"], #' + self.id + '_view_' + view).remove();
			});
			// check if any visible left
			buttons = switcher.find('.plupload_button');
			if (buttons.length === 1) {
				switcher.hide();
				view = buttons.eq(0).data('view');
				this._viewChanged(view);
			} else if ($.ui.button && buttons.length > 1) {
				if (this.options.views.remember && $.cookie) view = $.cookie('plupload_ui_view');
				// if wierd case, bail out to default
				if (! ~plupload.inArray(view, ['list', 'thumbs'])) view = this.options.views.active;
				switcher.show().buttonset().find('.ui-button').click(
					function (e) {
						view = $(this).data('view');
						self._viewChanged(view);
						e.preventDefault(); // avoid auto scrolling to widget in IE and FF (see #850)
					}
				);
				// if view not active - happens when switcher wasn't clicked manually
				button = switcher.find('[for="' + self.id + '_view_' + view + '"]');
				if (button.length) button.trigger('click');
			} else {
				switcher.show();
				this._viewChanged(this.options.views.active);
			}
			// initialize thumb viewer if requested
			if (this.options.views.thumbs) this._displayThumbs();
		},
		_enableRenaming: function () {
			var self = this;
			this.filelist.dblclick(function (e) {
				var nameSpan = $(e.target), nameInput, file, parts, name, ext = "";
				if (!nameSpan.hasClass('plupload_file_namespan')) return;
				// Get file name and split out name and extension
				file = self.uploader.getFile(nameSpan.closest('.plupload_file')[0].id);
				name = file.name;
				parts = /^(.+)(\.[^.]+)$/.exec(name);
				if (parts) {
					name = parts[1];
					ext = parts[2];
				}
				// Display input element
				nameInput = $('<input class="plupload_file_rename" type="text" />').width(nameSpan.width()).insertAfter(nameSpan.hide());
				nameInput.val(name).blur(function () {
					nameSpan.show().parent().scrollLeft(0).end().next().remove();
				}).keydown(function (e) {
					var nameInput = $(this);
					if ($.inArray(e.keyCode, [13, 27]) !== -1) {
						e.preventDefault();
						// Rename file and glue extension back on
						if (e.keyCode === 13) {
							file.name = nameInput.val() + ext;
							nameSpan.html(file.name);
						}
						nameInput.blur();
					}
				})[0].focus();
			});
		},
		_enableSortingList: function () {
			var self = this;
			if ($('.plupload_file', this.filelist).length < 2) return;
			// destroy sortable if enabled
			$('tbody', this.filelist).sortable('destroy');
			// enable
			this.filelist.sortable({
				items: '.plupload_delete',
				cancel: 'object, .plupload_clearer',
				stop: function () {
					var files = [];
					$.each($(this).sortable('toArray'), function (i, id) {
						files[files.length] = self.uploader.getFile(id);
					});
					files.unshift(files.length);
					files.unshift(0);
					// re-populate files array				
					Array.prototype.splice.apply(self.uploader.files, files);
				}
			});
		},
		Init: function () {
			// 첨부된 파일 삭제 및 queue 갯수 처리
			$("#" + this.id + "").plupload("getUploader").splice();
			// 초기데이터 바인딩
			var width = $(this.filelist).width();
			var Minimal = width > 250;
			var display = "";
			var name_width = "";
			if (!Minimal) {
				display = 'style="display:none;"';
				name_width = 'width:120px;';
			}
			// 초기 데이터 로드
			var file_html = '<li class="plupload_file ui-state-default" id="%id%">' +
				'<div class="plupload_file_thumb plupload_file_thumb_reload">' +
					'<img src="/Resources/Framework/ImageResize.aspx?UNID=%unid%&width=100&height=60" onclick="__ImageViewer(\'%unid%\');" style="cursor:pointer;" alt="%name%" />' +
				'</div>' +
				'<div class="plupload_file_name" title="%name%" onclick="__FileDownloadLink(\'%src%\');" style="cursor:pointer;' + name_width + '" onmouseover="$(this).find(\'span\').css(\'color\',\'#F4A460\');" onmouseout="$(this).find(\'span\').css(\'color\',\'#646464\');"><span class="plupload_file_extspan"><img src="/Resources/Images/ext/%ext%.gif" onerror="/Resources/Images/ext/common.gif" alt="" style="vertical-align:middle" /></span><span class="plupload_file_namespan">%name%</span></div>' +
				'<div class="plupload_file_action"><div class="ui-icon ui-icon-circle-minus" onclick="__ImageDelete(this,\'%unid%\');" style="cursor:pointer;"> </div></div>' +
				'<div class="plupload_file_size" ' + display + '>%size% </div>' +
				'<div class="plupload_file_status" ' + display + '>' +
					'<div class="plupload_file_progress ui-widget-header" style="width: 0%"> </div>' +
					'<span class="plupload_file_percent">%percent% </span>' +
				'</div>' +
				'<div class="plupload_file_fields"> </div>' +
			'</li>';
			// 내부 내용 삭제
			this.filelist.find("li").remove();
			// 데이터 로드
			// 초기화시 저장된 데이터를 바인딩한다.
			var data = $("#" + this.id + "_viewdata").val();
			var _files = new Array();
			if (data != "") {
				var data01 = data.split('^');
				for (var i = 0; i < data01.length; i++) {
					var data02 = data01[i].split('|');
					var obj = new Object();
					obj["name"] = data02[0];
					obj["size"] = data02[1];
					obj["ext"] = o.Mime.getFileExtension(obj.name) || 'none';
					obj["src"] = data02[2];
					obj["unid"] = data02[2].split('/$File/')[1];
					_files[i] = obj;
				}
				var filelist = this.filelist;
				$.each(_files, function (i, file) {
					var ext = o.Mime.getFileExtension(file.name) || 'none';
					filelist.append(file_html.replace(/%(\w+)%/g, function ($0, $1) {
						if ('size' === $1) {
							return file.size; // plupload.formatSize(file.size);
						} else if ('ext' === $1) {
							return ext;
						} else if ('unid' === $1) {
							return file.unid;
						} else {
							return file[$1] || '';
						}
					}));
				});
			}
			// 상태 리플레쉬
			$("#" + this.id + "").plupload("getUploader").refresh();
		}
	});
} (window, document, plupload, mOxie, jQuery));
