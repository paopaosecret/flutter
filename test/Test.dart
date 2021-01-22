
class Goods {
	String imgUrl;
	num amount;
	num marketPrice;
	String name;
	num id;
	Object cash;
	String mDetailUrl;

	Goods({
		this.imgUrl,
		this.amount,
		this.marketPrice,
		this.name,
		this.id,
		this.cash,
		this.mDetailUrl,
	});

	Goods.fromJson(Map<String, dynamic> json) {
		imgUrl = json['imgUrl'];
		amount = json['amount'];
		marketPrice = json['marketPrice'];
		name = json['name'];
		id = json['id'];
		cash = json['cash'];
		mDetailUrl = json['mDetailUrl'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['imgUrl'] = this.imgUrl;
		data['amount'] = this.amount;
		data['marketPrice'] = this.marketPrice;
		data['name'] = this.name;
		data['id'] = this.id;
		data['cash'] = this.cash;
		data['mDetailUrl'] = this.mDetailUrl;
	}
}

class Welfare {
	String smallTitle;
	String routeUrl;
	List<Goods> goods;
	String bigTitle;

	Welfare({
		this.smallTitle,
		this.routeUrl,
		this.goods,
		this.bigTitle,
	});

	Welfare.fromJson(Map<String, dynamic> json) {
		smallTitle = json['smallTitle'];
		routeUrl = json['routeUrl'];
		if (json['goods'] != null) {
			goods = new List<Goods>();
			json['goods'].forEach((v) {
				goods.add(new Goods.fromJson(v));
			});
		}
		bigTitle = json['bigTitle'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['smallTitle'] = this.smallTitle;
		data['routeUrl'] = this.routeUrl;
		if (this.goods != null) {
			data['goods'] = this.goods.map((v) => v.toJson()).toList();
		}
		data['bigTitle'] = this.bigTitle;
	}
}

class MyHelp {
	String smallTitle;
	String routeUrl;
	String bigTitle;

	MyHelp({
		this.smallTitle,
		this.routeUrl,
		this.bigTitle,
	});

	MyHelp.fromJson(Map<String, dynamic> json) {
		smallTitle = json['smallTitle'];
		routeUrl = json['routeUrl'];
		bigTitle = json['bigTitle'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['smallTitle'] = this.smallTitle;
		data['routeUrl'] = this.routeUrl;
		data['bigTitle'] = this.bigTitle;
	}
}

class MyOrder {
	String smallTitle;
	String routeUrl;
	String bigTitle;

	MyOrder({
		this.smallTitle,
		this.routeUrl,
		this.bigTitle,
	});

	MyOrder.fromJson(Map<String, dynamic> json) {
		smallTitle = json['smallTitle'];
		routeUrl = json['routeUrl'];
		bigTitle = json['bigTitle'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['smallTitle'] = this.smallTitle;
		data['routeUrl'] = this.routeUrl;
		data['bigTitle'] = this.bigTitle;
	}
}

class BasicMap {
	String imUrl;
	num updateTrend;
	String face;
	String scoreUrl;
	num level;
	String name;
	String linkUrl;
	num updateScore;
	num totalScore;
	num age;
	num status;

	BasicMap({
		this.imUrl,
		this.updateTrend,
		this.face,
		this.scoreUrl,
		this.level,
		this.name,
		this.linkUrl,
		this.updateScore,
		this.totalScore,
		this.age,
		this.status,
	});

	BasicMap.fromJson(Map<String, dynamic> json) {
		imUrl = json['imUrl'];
		updateTrend = json['updateTrend'];
		face = json['face'];
		scoreUrl = json['scoreUrl'];
		level = json['level'];
		name = json['name'];
		linkUrl = json['linkUrl'];
		updateScore = json['updateScore'];
		totalScore = json['totalScore'];
		age = json['age'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['imUrl'] = this.imUrl;
		data['updateTrend'] = this.updateTrend;
		data['face'] = this.face;
		data['scoreUrl'] = this.scoreUrl;
		data['level'] = this.level;
		data['name'] = this.name;
		data['linkUrl'] = this.linkUrl;
		data['updateScore'] = this.updateScore;
		data['totalScore'] = this.totalScore;
		data['age'] = this.age;
		data['status'] = this.status;
	}
}

class Data {
	Welfare welfare;
	MyHelp myHelp;
	MyOrder myOrder;
	BasicMap basicMap;

	Data({
		this.welfare,
		this.myHelp,
		this.myOrder,
		this.basicMap,
	});

	Data.fromJson(Map<String, dynamic> json) {
		welfare = json['welfare'] != null ?
			new Welfare.fromJson(json['welfare']) : null;
		myHelp = json['myHelp'] != null ?
			new MyHelp.fromJson(json['myHelp']) : null;
		myOrder = json['myOrder'] != null ?
			new MyOrder.fromJson(json['myOrder']) : null;
		basicMap = json['basicMap'] != null ?
			new BasicMap.fromJson(json['basicMap']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.welfare != null) {
			data['welfare'] = this.welfare.toJson();
		}
		if (this.myHelp != null) {
			data['myHelp'] = this.myHelp.toJson();
		}
		if (this.myOrder != null) {
			data['myOrder'] = this.myOrder.toJson();
		}
		if (this.basicMap != null) {
			data['basicMap'] = this.basicMap.toJson();
		}
	}
}

class Result {
	Data data;

	Result({
		this.data,
	});

	Result.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ?
			new Data.fromJson(json['data']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
			data['data'] = this.data.toJson();
		}
	}
}

class Response {
	num androidStatus;
	String msg;
	Result result;
	String status;

	Response({
		this.androidStatus,
		this.msg,
		this.result,
		this.status,
	});

	Response.fromJson(Map<String, dynamic> json) {
		androidStatus = json['androidStatus'];
		msg = json['msg'];
		result = json['result'] != null ?
			new Result.fromJson(json['result']) : null;
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['androidStatus'] = this.androidStatus;
		data['msg'] = this.msg;
		if (this.result != null) {
			data['result'] = this.result.toJson();
		}
		data['status'] = this.status;
	}
}
