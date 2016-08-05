/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
import UIKit

public class LoadRatingsInteractor: ServerReadConnectorInteractor {
	
	let entryId: Int64?
	let classPK: Int64?
	let className: String?
	let ratingsGroupCount: Int32

	var resultRating: RatingEntry?

	private init(screenlet: BaseScreenlet?,
	     	entryId: Int64?,
	     	classPK: Int64?,
	     	className: String?,
	     	ratingsGroupCount: Int32) {
		self.entryId = entryId
		self.classPK = classPK
		self.className = className
		self.ratingsGroupCount = ratingsGroupCount

		super.init(screenlet: screenlet)
	}

	convenience init(screenlet: BaseScreenlet?,
			entryId: Int64,
			ratingsGroupCount: Int32) {
		self.init(screenlet: screenlet,
			entryId: entryId,
			classPK: nil,
			className: nil,
			ratingsGroupCount: ratingsGroupCount)
	}

	convenience init(screenlet: BaseScreenlet?,
			classPK: Int64?,
			className: String?,
			ratingsGroupCount: Int32) {
		self.init(screenlet: screenlet,
		          entryId: nil,
		          classPK: classPK,
		          className: className,
		          ratingsGroupCount: ratingsGroupCount)
	}

	override public func createConnector() -> ServerConnector? {
		if let entryId = self.entryId {
			return LiferayServerContext.connectorFactory.createRatingLoadByEntryIdConnector(
				entryId: entryId, ratingsGroupCount: ratingsGroupCount)
		}
		else if let classPK = self.classPK, className = self.className {
			return LiferayServerContext.connectorFactory.createRatingLoadByClassPKConnector(classPK,
					className: className,
					ratingsGroupCount: ratingsGroupCount)
		}

		return nil
	}
	
	override public func completedConnector(op: ServerConnector) {
		if let loadOp = op as? RatingLoadByEntryIdLiferayConnector {
			self.resultRating = loadOp.resultRating
		} else if let loadOp = op as? RatingLoadByClassPKLiferayConnector {
			self.resultRating = loadOp.resultRating
		}
	}

}
