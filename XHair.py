import sys
from PyQt5.QtWidgets import (
    QApplication, QWidget, QHBoxLayout, QVBoxLayout, QLabel, QLineEdit, QPushButton,
    QFrame, QScrollArea, QGridLayout, QSizePolicy, QDialog, QTextEdit, QDialogButtonBox, QStackedWidget
)
from PyQt5.QtGui import QPainter, QColor, QPen, QIcon, QPixmap, QFont, QPolygon, QPainterPath
from PyQt5.QtCore import Qt, QSize, QPoint, pyqtSignal

# ---- Sidebar/Topbar/Icons ----

def sidebar_icon(name, size=22, gray=False):
    color = QColor("#FF4444" if not gray else "#444444")
    pix = QPixmap(size, size)
    pix.fill(Qt.transparent)
    p = QPainter(pix)
    p.setRenderHint(QPainter.Antialiasing)
    pen = QPen(color)
    pen.setWidth(3)
    p.setPen(pen)
    p.setBrush(Qt.NoBrush)
    c = size//2
    if name == "crosshair":
        p.drawLine(c, 4, c, size-4)
        p.drawLine(4, c, size-4, c)
    elif name == "display":
        p.drawRect(4, 8, size-8, size-14)
        p.drawRect(10, size-9, size-20, 5)
    elif name == "size":
        p.drawRect(5, 5, size-10, size-10)
        p.drawLine(6, size-6, size-6, 6)
    elif name == "key":
        p.drawEllipse(7,7,size-14,size-14)
        p.drawRect(5,14,size-10,6)
    elif name == "designer":
        p.drawEllipse(5,5,size-10,size-10)
        p.drawLine(c,5,c,size-5)
    elif name == "cursor":
        p.drawPolygon(QPolygon([QPoint(6,6), QPoint(6,size-6), QPoint(size-6,size//2)]))
    elif name == "options":
        for i in range(3):
            p.drawEllipse(6,6+i*7,4,4)
    elif name == "help":
        p.drawEllipse(4,4,size-8,size-8)
        f = QFont()
        f.setPointSize(int(size*0.6))
        p.setFont(f)
        p.setPen(color)
        p.drawText(pix.rect(), Qt.AlignCenter, "?")
    elif name == "log":
        p.drawEllipse(4,4,size-8,size-8)
        pen = QPen(color); pen.setWidth(2); p.setPen(pen)
        p.drawLine(c, c, c, 8)
        p.drawLine(c, c, c+7, c)
    elif name == "fav":
        # Heart
        path = QPainterPath()
        path.moveTo(c, size-6)
        path.cubicTo(size-3, size-13, c+8, 3, c, 7)
        path.cubicTo(c-8, 3, 3, size-13, c, size-6)
        p.setBrush(QColor("#FF4444" if not gray else "#444444"))
        p.setPen(Qt.NoPen)
        p.drawPath(path)
    p.end()
    return QIcon(pix)

def star_icon(filled=True, size=18, color="#FF4444"):
    pix = QPixmap(size, size)
    pix.fill(Qt.transparent)
    p = QPainter(pix)
    p.setRenderHint(QPainter.Antialiasing)
    points = [
        QPoint(size//2, 2), QPoint(int(size*0.62), int(size*0.32)),
        QPoint(size-3, int(size*0.4)), QPoint(int(size*0.70), int(size*0.62)),
        QPoint(int(size*0.78), size-3), QPoint(size//2, int(size*0.80)),
        QPoint(int(size*0.22), size-3), QPoint(int(size*0.30), int(size*0.62)),
        QPoint(3, int(size*0.40)), QPoint(int(size*0.38), int(size*0.32))
    ]
    path = QPainterPath()
    path.moveTo(points[0])
    for pt in points[1:]:
        path.lineTo(pt)
    path.closeSubpath()
    if filled:
        p.setBrush(QColor(color))
        p.setPen(QColor(color))
    else:
        p.setBrush(Qt.NoBrush)
        pen = QPen(QColor(color)); pen.setWidth(2); p.setPen(pen)
    p.drawPath(path)
    p.end()
    return QIcon(pix)

def logo_pixmap(width=160, height=32):
    pix = QPixmap(width, height)
    pix.fill(Qt.transparent)
    p = QPainter(pix)
    p.setRenderHint(QPainter.Antialiasing)
    pen = QPen(QColor("#FF4444")); pen.setWidth(7); pen.setCapStyle(Qt.RoundCap); p.setPen(pen)
    p.drawLine(11, 8, 28, 24)
    p.drawLine(11, 24, 28, 8)
    font = QFont("Segoe UI", 21, QFont.Bold)
    p.setFont(font)
    p.setPen(QColor("#FAFAFA"))
    p.drawText(38, 27, "hair")
    p.end()
    return QPixmap(pix)

# ---- Crosshair Pixmaps ----

def crosshair_pixmap(crosshair_type, size=16):
    pixmap = QPixmap(size, size)
    pixmap.fill(Qt.transparent)
    p = QPainter(pixmap)
    p.setRenderHint(QPainter.Antialiasing, False)
    c = size // 2
    if crosshair_type == 0:  # Green Plus
        pen = QPen(QColor("#00FF00")); pen.setWidth(size//4); pen.setCapStyle(Qt.SquareCap); p.setPen(pen)
        p.drawLine(2, c, c-2, c); p.drawLine(c+2, c, size-2, c)
        p.drawLine(c, 2, c, c-2); p.drawLine(c, c+2, c, size-2)
        pen = QPen(QColor("white")); pen.setWidth(max(1, size//8)); pen.setCapStyle(Qt.SquareCap); p.setPen(pen)
        p.drawLine(2, c, c-2, c); p.drawLine(c+2, c, size-2, c)
        p.drawLine(c, 2, c, c-2); p.drawLine(c, c+2, c, size-2)
    elif crosshair_type == 1:  # Red Plus
        pen = QPen(QColor("#FF4444")); pen.setWidth(size//4); pen.setCapStyle(Qt.SquareCap); p.setPen(pen)
        p.drawLine(2, c, c-2, c); p.drawLine(c+2, c, size-2, c)
        p.drawLine(c, 2, c, c-2); p.drawLine(c, c+2, c, size-2)
        pen = QPen(QColor("white")); pen.setWidth(max(1, size//8)); pen.setCapStyle(Qt.SquareCap); p.setPen(pen)
        p.drawLine(2, c, c-2, c); p.drawLine(c+2, c, size-2, c)
        p.drawLine(c, 2, c, c-2); p.drawLine(c, c+2, c, size-2)
    elif crosshair_type == 2:  # Green Circle
        pen = QPen(QColor("#00FF00")); pen.setWidth(size//4); pen.setCapStyle(Qt.RoundCap); p.setPen(pen)
        r = c - 2
        p.drawEllipse(c - r, c - r, 2 * r, 2 * r)
        pen = QPen(QColor("white")); pen.setWidth(max(1, size//8)); pen.setCapStyle(Qt.RoundCap); p.setPen(pen)
        p.drawEllipse(c - r, c - r, 2 * r, 2 * r)
    elif crosshair_type == 3:  # Red Circle
        pen = QPen(QColor("#FF4444")); pen.setWidth(size//4); pen.setCapStyle(Qt.RoundCap); p.setPen(pen)
        r = c - 2
        p.drawEllipse(c - r, c - r, 2 * r, 2 * r)
        pen = QPen(QColor("white")); pen.setWidth(max(1, size//8)); pen.setCapStyle(Qt.RoundCap); p.setPen(pen)
        p.drawEllipse(c - r, c - r, 2 * r, 2 * r)
    elif crosshair_type == 4:  # Black X
        pen = QPen(QColor("#111118")); pen.setWidth(size//4); pen.setCapStyle(Qt.SquareCap); p.setPen(pen)
        p.drawLine(2, 2, size-2, size-2)
        p.drawLine(2, size-2, size-2, 2)
        pen = QPen(QColor("white")); pen.setWidth(max(1, size//8)); pen.setCapStyle(Qt.SquareCap); p.setPen(pen)
        p.drawLine(4, 4, size-4, size-4)
        p.drawLine(4, size-4, size-4, 4)
    elif crosshair_type == 5:  # Blue X
        pen = QPen(QColor("#1A338C")); pen.setWidth(size//4); pen.setCapStyle(Qt.SquareCap); p.setPen(pen)
        p.drawLine(2, 2, size-2, size-2)
        p.drawLine(2, size-2, size-2, 2)
        pen = QPen(QColor("white")); pen.setWidth(max(1, size//8)); pen.setCapStyle(Qt.SquareCap); p.setPen(pen)
        p.drawLine(4, 4, size-4, size-4)
        p.drawLine(4, size-4, size-4, 4)
    # ---- New designs for 6+ ----
    elif crosshair_type == 6:  # Small white dot
        p.setBrush(QColor("white")); p.setPen(Qt.NoPen)
        p.drawEllipse(c-1, c-1, 2, 2)
    elif crosshair_type == 7:  # Cyan Circle
        pen = QPen(QColor("#00F6FF")); pen.setWidth(size//4); pen.setCapStyle(Qt.RoundCap); p.setPen(pen)
        r = c - 2
        p.drawEllipse(c - r, c - r, 2 * r, 2 * r)
    elif crosshair_type == 8:  # Purple X
        pen = QPen(QColor("#A95CFF")); pen.setWidth(size//4); pen.setCapStyle(Qt.SquareCap); p.setPen(pen)
        p.drawLine(2, 2, size-2, size-2)
        p.drawLine(2, size-2, size-2, 2)
    elif crosshair_type == 9:  # White Plus
        pen = QPen(QColor("white")); pen.setWidth(size//4); pen.setCapStyle(Qt.SquareCap); p.setPen(pen)
        p.drawLine(2, c, size-2, c)
        p.drawLine(c, 2, c, size-2)
    elif crosshair_type == 10:  # Small red dot
        p.setBrush(QColor("#FF4444")); p.setPen(Qt.NoPen)
        p.drawEllipse(c-1, c-1, 2, 2)
    elif crosshair_type == 11:  # Tiny green dot
        p.setBrush(QColor("#00FF00")); p.setPen(Qt.NoPen)
        p.drawEllipse(c-1, c-1, 2, 2)
    p.end()
    return pixmap

# ---- Overlay Window ----

class CrosshairOverlay(QWidget):
    def __init__(self):
        super().__init__()
        self.crosshair_type = None
        self.visible = True
        self.setWindowFlags(
            Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint | Qt.Tool
        )
        self.setAttribute(Qt.WA_TranslucentBackground)
        self.setAttribute(Qt.WA_TransparentForMouseEvents)
        self.resize(28, 28)
        self.hide()

    def set_crosshair(self, crosshair_type):
        self.crosshair_type = crosshair_type
        if self.visible:
            self.resize(28, 28)
            self.center_on_screen()
            self.show()
            self.update()

    def set_overlay_visible(self, visible):
        self.visible = visible
        if visible and self.crosshair_type is not None:
            self.center_on_screen()
            self.show()
            self.update()
        else:
            self.hide()

    def center_on_screen(self):
        screen = QApplication.primaryScreen().geometry()
        x = (screen.width() - self.width()) // 2
        y = (screen.height() - self.height()) // 2
        self.move(x, y)

    def paintEvent(self, event):
        if not self.visible or self.crosshair_type is None:
            return
        pix = crosshair_pixmap(self.crosshair_type, 16)
        qp = QPainter(self)
        x = (self.width() - pix.width()) // 2
        y = (self.height() - pix.height()) // 2
        qp.drawPixmap(x, y, pix)

# ---- Dialogs ----

class ChangelogDialog(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("Changelog")
        self.setStyleSheet("background: #18191C; color: #FAFAFA; font-size: 15px;")
        layout = QVBoxLayout(self)
        text = QTextEdit(self)
        text.setReadOnly(True)
        text.setStyleSheet("background: #232328; color: #FAFAFA; font-size: 15px;")
        text.setText(self.full_changelog())
        layout.addWidget(text)
        buttonBox = QDialogButtonBox(QDialogButtonBox.Ok)
        buttonBox.accepted.connect(self.accept)
        layout.addWidget(buttonBox)
        self.resize(500, 480)

    def full_changelog(self):
        return (
            "Xhair Changelog\n"
            "===============\n"
            "\n"
            "Alpha:\n"
            "- First public preview\n"
            "- Simple always-on-top overlay\n"
            "- Basic green/red plus crosshairs\n"
            "\n"
            "Beta:\n"
            "- Added sidebar, modern theme\n"
            "- Improved overlay transparency\n"
            "- Added crosshair selection grid\n"
            "\n"
            "0.40:\n"
            "- Major UI overhaul\n"
            "- Sidebar grouping, better icons\n"
            "- Overlay now click-through\n"
            "- Added black X, blue X crosshairs\n"
            "\n"
            "0.50:\n"
            "- Modern UI and sidebar\n"
            "- Red accent, new logo\n"
            "- All sidebar buttons interactive\n"
            "- Changelog/log button\n"
            "- Overlay is always-on-top and click-through\n"
            "- Overlay size like classic versions\n"
            "- Search bar and scrollable crosshair grid\n"
            "\n"
            "1.0:\n"
            "- Panel switching for ALL sidebar buttons\n"
            "- In-panel 'Favorites' view\n"
            "- Overlay hide/show via 'VISIBLE' button\n"
            "- Small crosshairs (overlay+grid)\n"
            "- Fresh crosshair designs\n"
            "- No popups except changelog\n"
            "- Everything is instant and modern\n"
        )

# ---- Crosshair Card ----

class CrosshairCard(QPushButton):
    clicked_crosshair = pyqtSignal(int)

    def __init__(self, pixmap, name, crosshair_type, favorited=False, on_fav_changed=None):
        super().__init__()
        self.setFixedSize(65, 65)
        self.favorited = favorited
        self.on_fav_changed = on_fav_changed
        self.pixmap = pixmap
        self.name = name
        self.crosshair_type = crosshair_type

        self.setCursor(Qt.PointingHandCursor)
        self.setStyleSheet("""
            QPushButton {
                background: #202124;
                border-radius: 10px;
                border: none;
            }
        """)

        # Star button
        self.star_btn = QPushButton(self)
        self.star_btn.setIcon(star_icon(filled=favorited))
        self.star_btn.setIconSize(QSize(17,17))
        self.star_btn.setFlat(True)
        self.star_btn.setGeometry(self.width()-22, 7, 16, 16)
        self.star_btn.setCursor(Qt.PointingHandCursor)
        self.star_btn.setStyleSheet("QPushButton {background: transparent; border: none;}")
        self.star_btn.clicked.connect(self.toggle_fav)

    def toggle_fav(self):
        self.favorited = not self.favorited
        self.star_btn.setIcon(star_icon(filled=self.favorited))
        if self.on_fav_changed:
            self.on_fav_changed(self.crosshair_type, self.favorited)

    def enterEvent(self, event):
        self.setStyleSheet("""
            QPushButton {
                background: #22222A;
                border-radius: 10px;
                border: 2px solid #FF4444;
            }
        """)
    def leaveEvent(self, event):
        self.setStyleSheet("""
            QPushButton {
                background: #202124;
                border-radius: 10px;
                border: none;
            }
        """)

    def paintEvent(self, event):
        super().paintEvent(event)
        p = QPainter(self)
        p.setRenderHint(QPainter.Antialiasing)
        iw, ih = self.pixmap.width(), self.pixmap.height()
        x = (self.width()-iw)//2
        y = (self.height()-ih)//2
        p.drawPixmap(x, y, self.pixmap)
        p.setPen(Qt.white)
        p.setFont(QFont("Segoe UI", 8))
        p.drawText(0, self.height()-6, self.width(), 12, Qt.AlignHCenter, self.name)
        p.end()

    def mousePressEvent(self, event):
        if self.star_btn.geometry().contains(event.pos()):
            return super().mousePressEvent(event)
        if event.button() == Qt.LeftButton:
            self.clicked_crosshair.emit(self.crosshair_type)
        return super().mousePressEvent(event)

# ---- Panel Widgets ----

class CrosshairPanel(QWidget):
    def __init__(self, crosshair_info, fav_set, overlay_callback):
        super().__init__()
        self.overlay_callback = overlay_callback
        self.fav_set = fav_set
        self.cards = []
        self.grid = QGridLayout()
        self.grid.setSpacing(14)
        self.grid.setContentsMargins(16, 8, 16, 8)
        for idx, (name, t) in enumerate(crosshair_info):
            pix = crosshair_pixmap(t, 16)
            card = CrosshairCard(pix, name, t, favorited=(t in fav_set), on_fav_changed=self.on_fav_changed)
            card.clicked_crosshair.connect(self.overlay_callback)
            self.cards.append(card)
            self.grid.addWidget(card, idx//6, idx%6)
        self.setLayout(self.grid)

    def on_fav_changed(self, t, f):
        if f: self.fav_set.add(t)
        else: self.fav_set.discard(t)

    def update_favs(self):
        for card in self.cards:
            card.favorited = (card.crosshair_type in self.fav_set)
            card.star_btn.setIcon(star_icon(filled=card.favorited))

class FavoritesPanel(QWidget):
    def __init__(self, crosshair_info, fav_set, overlay_callback):
        super().__init__()
        self.overlay_callback = overlay_callback
        self.fav_set = fav_set
        self.crosshair_info = crosshair_info
        self.grid = QGridLayout()
        self.grid.setSpacing(14)
        self.grid.setContentsMargins(16, 8, 16, 8)
        self.setLayout(self.grid)
        self.update_fav_cards()

    def update_fav_cards(self):
        # Remove old
        while self.grid.count():
            w = self.grid.takeAt(0).widget()
            if w: w.deleteLater()
        cards = []
        idx = 0
        for name, t in self.crosshair_info:
            if t in self.fav_set:
                pix = crosshair_pixmap(t, 16)
                card = CrosshairCard(pix, name, t, favorited=True)
                card.clicked_crosshair.connect(self.overlay_callback)
                cards.append(card)
                self.grid.addWidget(card, idx//6, idx%6)
                idx += 1

class ComingSoonPanel(QWidget):
    def __init__(self, text="Coming Soon!"):
        super().__init__()
        layout = QVBoxLayout(self)
        label = QLabel(text, self)
        label.setStyleSheet("font-size: 32px; color: #FF4444;")
        label.setAlignment(Qt.AlignCenter)
        layout.addStretch(1)
        layout.addWidget(label)
        layout.addStretch(1)

class LogPanel(QWidget):
    def __init__(self):
        super().__init__()
        layout = QVBoxLayout(self)
        text = QTextEdit(self)
        text.setReadOnly(True)
        text.setStyleSheet("background: #232328; color: #FAFAFA; font-size: 15px;")
        text.setText(ChangelogDialog().full_changelog())
        layout.addWidget(text)
        self.setLayout(layout)

# ---- Main Window ----

class XhairMainWindow(QWidget):
    def __init__(self, overlay):
        super().__init__()
        self.overlay = overlay
        self.setWindowTitle("Xhair 1.0")
        self.setMinimumSize(900, 650)
        self.setStyleSheet("background: #18191C;")
        self.fav_set = set()
        # Crosshair info: (name, type)
        self.crosshair_info = [
            ("Green Plus",0), ("Red Plus",1), ("Green Circle",2), ("Red Circle",3),
            ("Black X",4), ("Blue X",5),
            ("White Dot",6), ("Cyan Circle",7), ("Purple X",8), ("White Plus",9), ("Red Dot",10), ("Green Dot",11)
        ]
        self.init_ui()

    def init_ui(self):
        main_layout = QHBoxLayout(self)
        main_layout.setContentsMargins(0,0,0,0)
        main_layout.setSpacing(0)
        # --- Sidebar ---
        sidebar = QVBoxLayout()
        sidebar.setContentsMargins(0, 0, 0, 0)
        sidebar.setSpacing(3)
        sidebar_frame = QFrame()
        sidebar_frame.setFixedWidth(74)
        sidebar_frame.setStyleSheet("background: #17171A; border-right: 1px solid #222224;")
        sidebar.setAlignment(Qt.AlignTop)

        def add_btn(name, icon, tag, tooltip=""):
            btn = QPushButton()
            btn.setIcon(icon)
            btn.setIconSize(QSize(22,22))
            btn.setFixedSize(54,36)
            btn.setStyleSheet("QPushButton {border:none; background: #222224; border-radius: 10px;} QPushButton:focus {outline: none;}")
            btn.setToolTip(tooltip or name)
            btn.clicked.connect(lambda: self.switch_panel(tag))
            sidebar.addWidget(btn, alignment=Qt.AlignHCenter)
            self.sidebar_btns[tag] = btn

        self.sidebar_btns = {}
        sidebar.addSpacing(8)
        sidebar.addWidget(QLabel("<span style='color:#6E6E6E;font-size:11px;margin-left:7px;'>Essentials</span>"))
        add_btn("Crosshairs", sidebar_icon("crosshair"), "crosshairs")
        add_btn("Display", sidebar_icon("display"), "display")
        add_btn("Size/Pos", sidebar_icon("size"), "size")

        sidebar.addSpacing(6)
        sidebar.addWidget(QLabel("<span style='color:#6E6E6E;font-size:11px;margin-left:7px;'>Customization</span>"))
        add_btn("Keybinds", sidebar_icon("key"), "keybinds")
        add_btn("Designer", sidebar_icon("designer"), "designer")
        add_btn("Cursor", sidebar_icon("cursor"), "cursor")

        sidebar.addSpacing(6)
        sidebar.addWidget(QLabel("<span style='color:#6E6E6E;font-size:11px;margin-left:7px;'>Support</span>"))
        add_btn("Options", sidebar_icon("options"), "options")
        add_btn("Help", sidebar_icon("help"), "help")

        sidebar.addSpacing(6)
        add_btn("Favorites", sidebar_icon("fav"), "favorites", "Show Favorites")
        sidebar.addSpacing(6)
        add_btn("Log", sidebar_icon("log"), "log", "Changelog / Log")
        sidebar.addStretch(1)
        sidebar_frame.setLayout(sidebar)
        main_layout.addWidget(sidebar_frame)

        # --- Right Panel Layout ---
        right = QVBoxLayout()
        right.setSpacing(0)
        right.setContentsMargins(0,0,0,0)

        # --- Top Bar ---
        topbar = QHBoxLayout()
        topbar.setContentsMargins(18, 9, 24, 9)
        topbar.setSpacing(18)
        logo = QLabel()
        logo.setPixmap(logo_pixmap())
        logo.setFixedHeight(32)
        topbar.addWidget(logo, alignment=Qt.AlignLeft)
        topbar.addSpacing(5)

        # Top Tab: Featured
        featured_btn = QPushButton("Featured")
        featured_btn.setStyleSheet("""
            QPushButton {
                color: #FF4444;
                font-weight: bold;
                font-size: 15px;
                padding: 3px 14px;
                border: none;
                border-bottom: 3px solid #FF4444;
                background: transparent;
            }
            QPushButton:pressed { color: #FF8888; }
        """)
        featured_btn.setFixedHeight(26)
        topbar.addWidget(featured_btn)
        topbar.addStretch(1)

        # Topbar right: "VISIBLE" + circle toggler
        self.visible_btn = QPushButton("VISIBLE")
        self.visible_btn.setStyleSheet("""
            QPushButton {
                color: #8E8E8E;
                font-size: 13px;
                background: #232328;
                border-radius: 10px;
                padding: 4px 16px 4px 16px;
                border: 1px solid #232328;
            }
            QPushButton:checked { color: #FF4444; }
        """)
        self.visible_btn.setCheckable(True)
        self.visible_btn.setChecked(True)
        circ = QLabel()
        circ.setFixedSize(16,16)
        circ_pix = QPixmap(16,16)
        circ_pix.fill(Qt.transparent)
        p = QPainter(circ_pix)
        p.setRenderHint(QPainter.Antialiasing)
        p.setBrush(QColor("#FF4444"))
        p.setPen(Qt.NoPen)
        p.drawEllipse(2,2,12,12)
        p.end()
        circ.setPixmap(circ_pix)
        topbar.addWidget(self.visible_btn)
        topbar.addWidget(circ)
        self.visible_btn.clicked.connect(self.toggle_overlay)

        # -- Search Bar Row --
        search_row = QHBoxLayout()
        search_row.setContentsMargins(18, 5, 18, 0)
        search_row.setSpacing(0)
        self.search = QLineEdit()
        self.search.setPlaceholderText("Search crosshairs...")
        self.search.setStyleSheet("""
            QLineEdit {
                background: #232328;
                border-radius: 10px;
                border: 2px solid #2F2F36;
                color: #FAFAFA;
                font-size: 15px;
                padding-left: 12px;
                min-height: 28px;
            }
            QLineEdit:focus { border: 2px solid #FF4444; }
        """)
        self.search.setFixedWidth(240)
        self.search.textChanged.connect(self.do_search)
        search_row.addWidget(self.search)
        search_row.addStretch(1)

        # --- Stacked Panels ---
        self.stacked = QStackedWidget()
        self.panel_tags = {}
        # Crosshairs grid
        self.grid_panel = CrosshairPanel(self.crosshair_info, self.fav_set, self.select_crosshair)
        self.stacked.addWidget(self.grid_panel)
        self.panel_tags['crosshairs'] = self.stacked.count() - 1
        # Display panel
        self.stacked.addWidget(ComingSoonPanel("Display Modes: Coming Soon"))
        self.panel_tags['display'] = self.stacked.count() - 1
        # Size/Pos
        self.stacked.addWidget(ComingSoonPanel("Size && Position: Coming Soon"))
        self.panel_tags['size'] = self.stacked.count() - 1
        # Keybinds
        self.stacked.addWidget(ComingSoonPanel("Keybinds: Coming Soon"))
        self.panel_tags['keybinds'] = self.stacked.count() - 1
        # Designer
        self.stacked.addWidget(ComingSoonPanel("Designer: Coming Soon"))
        self.panel_tags['designer'] = self.stacked.count() - 1
        # Cursor
        self.stacked.addWidget(ComingSoonPanel("Cursor: Coming Soon"))
        self.panel_tags['cursor'] = self.stacked.count() - 1
        # Options
        self.stacked.addWidget(ComingSoonPanel("Options: Coming Soon"))
        self.panel_tags['options'] = self.stacked.count() - 1
        # Help
        self.stacked.addWidget(ComingSoonPanel("Help: Coming Soon"))
        self.panel_tags['help'] = self.stacked.count() - 1
        # Favorites
        self.fav_panel = FavoritesPanel(self.crosshair_info, self.fav_set, self.select_crosshair)
        self.stacked.addWidget(self.fav_panel)
        self.panel_tags['favorites'] = self.stacked.count() - 1
        # Log
        self.stacked.addWidget(LogPanel())
        self.panel_tags['log'] = self.stacked.count() - 1

        # Arrange right panel
        topbar_widget = QWidget(); topbar_widget.setLayout(topbar); topbar_widget.setStyleSheet("background: #181A1C; border-bottom: 1px solid #202124;")
        right.addWidget(topbar_widget)
        search_widget = QWidget(); search_widget.setLayout(search_row)
        right.addWidget(search_widget)
        right.addWidget(self.stacked)
        main_layout.addLayout(right, stretch=1)

        # Default panel
        self.switch_panel("crosshairs")

    def switch_panel(self, tag):
        if tag in self.panel_tags:
            self.stacked.setCurrentIndex(self.panel_tags[tag])
            # Update favs if going to favs
            if tag == 'favorites':
                self.fav_panel.update_fav_cards()
            if tag == 'crosshairs':
                self.grid_panel.update_favs()
        # Highlight button
        for t, btn in self.sidebar_btns.items():
            if t == tag:
                btn.setStyleSheet("QPushButton {background: #1A338C; border-radius: 10px;} QPushButton:focus {outline: none;}")
            else:
                btn.setStyleSheet("QPushButton {background: #222224; border-radius: 10px;} QPushButton:focus {outline: none;}")

    def toggle_overlay(self):
        show = self.visible_btn.isChecked()
        self.overlay.set_overlay_visible(show)
        # Change color of label/circle
        if show:
            self.visible_btn.setText("VISIBLE")
        else:
            self.visible_btn.setText("HIDDEN")

    def select_crosshair(self, crosshair_type):
        self.overlay.set_crosshair(crosshair_type)

    def do_search(self, text):
        text = text.strip().lower()
        if not text:
            # restore full grid
            self.grid_panel.setParent(None)
            self.grid_panel = CrosshairPanel(self.crosshair_info, self.fav_set, self.select_crosshair)
            self.stacked.insertWidget(self.panel_tags['crosshairs'], self.grid_panel)
            self.stacked.setCurrentIndex(self.panel_tags['crosshairs'])
            return
        # filter grid by name
        filtered = [(name, t) for name, t in self.crosshair_info if text in name.lower()]
        panel = CrosshairPanel(filtered, self.fav_set, self.select_crosshair)
        self.stacked.insertWidget(self.panel_tags['crosshairs'], panel)
        self.stacked.setCurrentIndex(self.panel_tags['crosshairs'])
        self.grid_panel = panel

# ---- App Entrypoint ----

def main():
    app = QApplication(sys.argv)
    overlay = CrosshairOverlay()
    overlay.show()
    win = XhairMainWindow(overlay)
    win.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()
