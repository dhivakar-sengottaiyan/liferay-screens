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


class ForgotPasswordInteractor: ServerOperationInteractor {

	var resultPasswordSent: Bool?

	override func createOperation() -> LiferayForgotPasswordBaseOperation {
		let screenlet = self.screenlet as ForgotPasswordScreenlet

		switch AuthMethod.create(screenlet.authMethod) {
			case .ScreenName:
				return LiferayForgotPasswordScreenNameOperation(screenlet: screenlet)
			case .UserId:
				return LiferayForgotPasswordUserIdOperation(screenlet: screenlet)
			default: ()
		}

		return LiferayForgotPasswordEmailOperation(screenlet: screenlet)
	}

	override func completedOperation(op: ServerOperation) {
		self.resultPasswordSent = (op as LiferayForgotPasswordBaseOperation).resultPasswordSent
	}

}
