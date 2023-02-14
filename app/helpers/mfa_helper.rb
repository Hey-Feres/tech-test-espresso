module MfaHelper
	def render_qrcode
		totp = ROTP::TOTP.new("base32secret3232", issuer: "Espresso Tech Test")
    uri = totp.provisioning_uri(current_user.email)
    qrcode = RQRCode::QRCode.new(uri)
    svg = qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 3,
      standalone: true,
      use_path: true
    )

    svg.html_safe
	end
end
