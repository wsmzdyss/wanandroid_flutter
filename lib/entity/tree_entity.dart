class TreeBaseEntity {
	List<TreeData> data;
	int errorCode;
	String errorMsg;

	TreeBaseEntity({this.data, this.errorCode, this.errorMsg});

	TreeBaseEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			data = new List<TreeData>();(json['data'] as List).forEach((v) { data.add(new TreeData.fromJson(v)); });
		}
		errorCode = json['errorCode'];
		errorMsg = json['errorMsg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['errorCode'] = this.errorCode;
		data['errorMsg'] = this.errorMsg;
		return data;
	}
}

class TreeData {
	int visible;
	List<TreeChild> children;
	String name;
	bool userControlSetTop;
	int id;
	int courseId;
	int parentChapterId;
	int order;

	TreeData({this.visible, this.children, this.name, this.userControlSetTop, this.id, this.courseId, this.parentChapterId, this.order});

	TreeData.fromJson(Map<String, dynamic> json) {
		visible = json['visible'];
		if (json['children'] != null) {
			children = new List<TreeChild>();(json['children'] as List).forEach((v) { children.add(new TreeChild.fromJson(v)); });
		}
		name = json['name'];
		userControlSetTop = json['userControlSetTop'];
		id = json['id'];
		courseId = json['courseId'];
		parentChapterId = json['parentChapterId'];
		order = json['order'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['visible'] = this.visible;
		if (this.children != null) {
      data['children'] =  this.children.map((v) => v.toJson()).toList();
    }
		data['name'] = this.name;
		data['userControlSetTop'] = this.userControlSetTop;
		data['id'] = this.id;
		data['courseId'] = this.courseId;
		data['parentChapterId'] = this.parentChapterId;
		data['order'] = this.order;
		return data;
	}
}

class TreeChild {
	int visible;
	List<Null> children;
	String name;
	bool userControlSetTop;
	int id;
	int courseId;
	int parentChapterId;
	int order;

	TreeChild({this.visible, this.children, this.name, this.userControlSetTop, this.id, this.courseId, this.parentChapterId, this.order});

	TreeChild.fromJson(Map<String, dynamic> json) {
		visible = json['visible'];
		if (json['children'] != null) {
			children = new List<Null>();
		}
		name = json['name'];
		userControlSetTop = json['userControlSetTop'];
		id = json['id'];
		courseId = json['courseId'];
		parentChapterId = json['parentChapterId'];
		order = json['order'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['visible'] = this.visible;
		if (this.children != null) {
      data['children'] =  [];
    }
		data['name'] = this.name;
		data['userControlSetTop'] = this.userControlSetTop;
		data['id'] = this.id;
		data['courseId'] = this.courseId;
		data['parentChapterId'] = this.parentChapterId;
		data['order'] = this.order;
		return data;
	}
}
